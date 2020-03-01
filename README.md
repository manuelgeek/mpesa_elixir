# Mpesa 
Phoenix(Elixir) wrapper for Mpesa STK(Lipa na Mpesa Online) implentation.

## Installation

The package can be installed
by adding `mpesa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mpesa, "~> 0.1.0"}
  ]
end
```
Run `mix deps.get` to fetch from Hex

## Configuration

Add below cofix to dec.exs / prod.exs files
This asumes you have a clear understanding of how Daraja API works.

```elixir
config :mpesa,
  env: "sandbox",
  consumer_key: "",
  consumer_secret: "",
  mpesa_short_code: "",
  mpesa_passkey: "",
  mpesa_callback_url: ""
```


## Usage 

```elixir
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
```

## Documentation 
 [https://hexdocs.pm/mpesa](https://hexdocs.pm/mpesa/Mpesa.html).

 ## AUthor 

[ManuEl Geek](https://manuel.appslab.co.ke)

## Licence

Mpesa Elixir is released under [MIT License](https://github.com/appcues/exsentry/blob/master/LICENSE.txt)