defmodule Mpesa do
  @moduledoc """
  Documentation for `Mpesa`.
  """

  @doc false
  def get_url do
    if Application.get_env(:mpesa, :env) === "sandbox" do
      "https://sandbox.safaricom.co.ke"
    else
      "https://api.safaricom.co.ke"
    end
  end

  @doc false
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

  @doc false
  def get_token(%{status_code: 400} = _response) do
    {:error, "Wrong Credentials"}
  end

  @doc false
  def get_token(%{status_code: 200, body: body} = _response) do
    {:ok, body} = body |> Poison.decode()
    {:ok, body["access_token"]}
  end

  @doc """
  Initiates the Mpesa Lipa Online STK Push .

  ## Configuration

  Add below config to dec.exs / prod.exs files 
  This asumes you have a clear understanding of how Daraja API works.

  The `env` is either `sandbox` or `production`

  `dev.exs` These are sandbox credentials given by Safaricom
  ```elixir
  config :mpesa,
  env: "sandbox",
  consumer_key: "72yw1nun6g1QQPPgOsAObCGSfuimGO7b",
  consumer_secret: "vRzZiD5RllMLIdLD",
  mpesa_short_code: "174379",
  mpesa_passkey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
  mpesa_callback_url: "http://91eb0af5.ngrok.io/api/payment/callback"
  ```


  `prod.secret.exs`
  ```elixir
  config :mpesa,
  env: "production",
  consumer_key: "",
  consumer_secret: "",
  mpesa_short_code: "",
  mpesa_passkey: "",
  mpesa_callback_url: ""
  ```

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

      _ ->
        {:error, 'An Error occurred, try again'}
    end
  end

  @doc false
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

  @doc false
  def get_response_body(%{status_code: 200, body: body} = _response) do
    {:ok, _body} = body |> Poison.decode()
  end

  @doc false
  def get_response_body(%{status_code: 404} = _response) do
    {:error, "Invalid Access Token"}
  end

  @doc false
  def get_response_body(%{status_code: 500} = _response) do
    {:error,
     "Unable to lock subscriber, a transaction is already in process for the current subscriber"}
  end
end
