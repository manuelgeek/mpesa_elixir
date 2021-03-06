[![Build Status](https://www.travis-ci.com/manuelgeek/mpesa_elixir.svg?branch=master)](https://www.travis-ci.com/manuelgeek/mpesa_elixir)
![hex badge](https://img.shields.io/hexpm/dt/mpesa)
# Mpesa Elixir
Phoenix(Elixir) wrapper for Mpesa STK(Lipa na Mpesa Online) implentation.

## Table of contents
 - [Features](#features)
 - [Installation](#installation)
 - [Configuration](#configuration)
 - [Usage](#usage)
 - [Documentation](#documentation)
 - [Author](#author)
 - [Licence](#licence)

## Features

## Installation

The package can be installed
by adding `mpesa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mpesa, "~> 0.1.2"}
  ]
end
```
Run `mix deps.get` to fetch from Hex

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

 ## Author
 <p align="center"><img src="https://magak.me/assets/images/Geek-logo.png" width="150"></p>
 

[ManuEl Geek](https://magak.me)

## Licence

Mpesa Elixir is released under [MIT License](https://github.com/appcues/exsentry/blob/master/LICENSE.txt)

[![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=for-the-badge)](#)

[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source-200x33.png?v=103)](#)


Happy coding, Star before Fork 😊💪💯
