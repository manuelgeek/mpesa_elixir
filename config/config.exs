use Mix.Config

config :mpesa,
env: "sandbox",
  consumer_key: "72yw1nun6g1QQPPgOsAObCGSfuimGO7b",
  consumer_secret: "vRzZiD5RllMLIdLD",
  mpesa_short_code: "174379",
  mpesa_passkey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
  mpesa_callback_url: "http://91eb0af5.ngrok.io/api/payment/callback"
