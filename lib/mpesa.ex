defmodule Mpesa do
  @moduledoc """
  Documentation for `Mpesa`.
  """

  @doc """
  Gets the URL , depending on the env.
  """
  def get_url do
    if Application.get_env(:mpesa, :env) === "sandbox" do
      "https://sandbox.safaricom.co.ke"
    else
      "https://production.safaricom.co.ke"
    end
  end

  @doc """
  Gets the Access Token .

  ## Examples

      iex> Mpesa.authorize()
      {:ok, "zUqIM1WR9cfG2KHHtrk0B8NTQrLX"}
      {:error, "Wrong Credentials"}

  """
  def authorize do
    url = get_url() <> "/oauth/v1/generate?grant_type=client_credentials"

    string =
      Application.get_env(:mpesa, :consumer_key) <>
        ":" <> Application.get_env(:mpesa, :consumer_secret)

    token = Base.encode64(string)

    headers = [
      {"Authorization", "Basic #{token}"},
      {"Content-Type", "application/json"}
    ]

    HTTPoison.start()
    {:ok, response} = HTTPoison.get(url, headers)
    get_token(response)
  end

  def get_token(%{status_code: 400} = _response) do
    {:error, "Wrong Credentials"}
  end

  def get_token(%{status_code: 200, body: body} = _response) do
    {:ok, body} = body |> Poison.decode()
    {:ok, body["access_token"]}
  end

  @doc """
  Initiates the Mpesa Lipa Online STK Push .

  ## Examples

      iex> Mpesa.make_request(10, "254724540039", "reference", "description")
      {:ok,
        %{
        "CheckoutRequestID" => "ws_CO_010320202011179845",
        "CustomerMessage" => "Success. Request accepted for processing",
        "MerchantRequestID" => "25558-10595705-4",
        "ResponseCode" => "0",
        "ResponseDescription" => "Success. Request accepted for processing"
        }}

        {:error, "Invalid Access Token"}

  """
  def make_request(amount, phone, reference, description) do
    case authorize() do
      {:ok, token} ->
        request(token, amount, phone, reference, description)

      {:error, message} ->
        {:error, message}
    end
  end

  def request(token, amount, phone, reference, description) do
    url = get_url() <> "/mpesa/stkpush/v1/processrequest"
    paybill = Application.get_env(:mpesa, :mpesa_short_code)
    passkey = Application.get_env(:mpesa, :mpesa_passkey)
    {:ok, timestamp} = Timex.now() |> Timex.format("%Y%m%d%H%M%S", :strftime)
    password = Base.encode64(paybill <> passkey <> timestamp)

    payload = %{
      "BusinessShortCode" => paybill,
      "Password" => password,
      "Timestamp" => timestamp,
      "TransactionType" => "CustomerPayBillOnline",
      "Amount" => amount,
      "PartyA" => phone,
      "PartyB" => paybill,
      "PhoneNumber" => phone,
      "CallBackURL" => Application.get_env(:mpesa, :mpesa_callback_url),
      "AccountReference" => reference,
      "TransactionDesc" => description
    }

    request_body = Poison.encode!(payload)

    headers = [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json"}
    ]

    {:ok, response} = HTTPoison.post(url, request_body, headers)
    get_response_body(response)
  end

  def get_response_body(%{status_code: 200, body: body} = _response) do
    {:ok, _body} = body |> Poison.decode()
  end

  def get_response_body(%{status_code: 404} = _response) do
    {:error, "Invalid Access Token"}
  end
end
