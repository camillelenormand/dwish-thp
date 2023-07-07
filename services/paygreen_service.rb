require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module PaygreenService
  API_BASE_URL = 'https://sb-api.paygreen.fr'.freeze

  def self.authenticate

    # get shop_id and secret_key from ENV
    shop_id = ENV['PAYGREEN_SHOP_ID']
    p shop_id
    secret_key = ENV['PAYGREEN_SECRET_KEY']
    p secret_key

    # create url
    url = URI("#{API_BASE_URL}/auth/authentication/#{shop_id}/secret-key")
    p url

    # create http request
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = secret_key
    p "request: #{request}"
    
    # send request
    response = http.request(request)
    p response

    # get token from response
    if response.is_a?(Net::HTTPSuccess)
      @token = JSON.parse(response.body)["data"]["token"]
    else
      raise "Error: #{response.body}"
    end

  end

  # create payment order
  def self.create_payment_order(amount, first_name, last_name, email, phone, user_id)

    # get token from authenticate method
    token = @token || authenticate
    shop_id = ENV['PAYGREEN_SHOP_ID']
    p shop_id

    # get return_url and cancel_url from ENV
    if Rails.env.production?
      return_url = URI(Rails.application.config.return_url)
      p return_url
      cancel_url = URI(Rails.application.config.cancel_url)
      p cancel_url
    elsif Rails.env.development?
      return_url = URI(Rails.application.config.return_url)
      p return_url
      cancel_url = URI(Rails.application.config.cancel_url)
      p cancel_url
    elsif Rails.env.test?
      return_url = URI(Rails.application.config.return_url)
      p return_url
      cancel_url = URI(Rails.application.config.cancel_url)
      p cancel_url
    else
      return "Error: Rails.env not set"
    end

    # create url
    url = URI("https://sb-api.paygreen.fr/payment/payment-orders")

    # create http request
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    # create request
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
      return_url: return_url,
      cancel_url: cancel_url,
      buyer: {
        first_name: first_name,
        last_name: last_name,
        email: email,
        phone: phone,
        external_id: user_id
      },
      amount: amount * 100,
      shop_id: shop_id
    }.to_json

    # send request
    response = http.request(request)
    puts response.read_body

    # get hosted_payment_url and payment_order status and id from response
    if response.is_a?(Net::HTTPSuccess)
      hosted_payment_url = JSON.parse(response.body)["data"]["hosted_payment_url"]
      payment_order_id = JSON.parse(response.body)["data"]["id"]
      payment_order_status = JSON.parse(response.body)["data"]["status"]
      return {
        hosted_payment_url: hosted_payment_url,
        payment_order_id: payment_order_id,
        payment_order_status: payment_order_status
        
      }
    else
      raise "API request failed with status: #{response.code}"
    end

  end

  # get payment order
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

    # get payment status and transaction id from response
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
      }
    else
      raise "Error: #{response.body}"
    end
  end

  # create buyer in Paygreen
  def self.create_buyer(first_name, last_name, email, phone_number, user_id)
    token = @token || authenticate
    url = URI("#{API_BASE_URL}/payment/buyers")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = "Bearer #{token}"
    
    request.body = {
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone_number: phone_number,
      reference: "Dwish_Customer_"+user_id,
    }.to_json

    response = http.request(request)
    puts response.read_body
    
    if response.is_a?(Net::HTTPSuccess)
      buyer_id = JSON.parse(response.body)["data"]["id"]
      return {
        buyer_id: buyer_id
      }
  
    else
      raise "Error: #{response.body}"
    end

  end

end