require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module PaygreenService
  API_BASE_URL = 'https://sb-api.paygreen.fr'.freeze

  def self.authenticate
    shop_id = ENV["PAYGREEN_SHOP_ID"]
    secret_key = ENV["PAYGREEN_SECRET_KEY"]

    url = URI("#{API_BASE_URL}/auth/authentication/#{shop_id}/secret-key")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = secret_key
    
    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      @token = JSON.parse(response.body)["data"]["token"]
    else
      raise "Error: #{response.body}"
    end

  end

  def self.create_payment_order(amount, first_name, last_name, email)
    token = @token || authenticate
    shop_id = ENV["PAYGREEN_SHOP_ID"]

    url = URI("https://sb-api.paygreen.fr/payment/payment-orders")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = "Bearer #{token}"
    request.body = {
      auto_capture: true,
      currency: "eur",
      merchant_initiated: false,
      mode: "instant",
      partial_allowed: false,
      buyer: {
        first_name: first_name,
        last_name: last_name,
        email: email
      },
      amount: amount * 100,
      shop_id: shop_id
    }.to_json

    response = http.request(request)
    if response.is_a?(Net::HTTPSuccess)
      hosted_payment_url = JSON.parse(response.body)["data"]["hosted_payment_url"]
      payment_order_id = JSON.parse(response.body)["data"]["id"]
      return {
        hosted_payment_url: hosted_payment_url,
        payment_order_id: payment_order_id,
        
      }
    else
      raise "Error: #{response.body}"
    end

  end

  def self.get_payment_order(payment_order_id)
    token = @token || authenticate
    url = URI("#{API_BASE_URL}/payment/payment-orders/#{payment_order_id}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = "Bearer #{token}"

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      # get payment status and transaction id from response
      payment_order_status = JSON.parse(response.body)["data"]["status"]
      id = JSON.parse(response.body)["data"]["id"]
      transaction_id = JSON.parse(response.body)["data"]["transactions"][0]["id"] 
      transaction_status = JSON.parse(response.body)["data"]["transactions"][0]["status"]
      operation_id = JSON.parse(response.body)["data"]["transactions"][0]["operations"][0]["id"]
      return {
        payment_order_status: payment_order_status,
        payment_order_id: payment_order_id,
        transaction_id: transaction_id,
        transaction_status: transaction_status,
        operation_id: operation_id,
      }
    else
      raise "Error: #{response.body}"
    end

  end

end