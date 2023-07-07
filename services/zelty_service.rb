require 'uri'
require 'net/http'
require 'openssl'
require 'json'

module ZeltyService
  API_BASE_URL = 'https://api.zelty.fr/2.7/'.freeze
  PRODUCTS_ENDPOINT = '/catalog/dishes'.freeze
  TAGS_ENDPOINT = '/catalog/tags'.freeze
  ZELTY_ID_PRODUCTION = ENV['ZELTY_ID_PRODUCTION']
  ZELTY_ID_SANDBOX = ENV['ZELTY_ID_SANDBOX']

  def self.getAllProducts

    url = URI("#{API_BASE_URL}#{PRODUCTS_ENDPOINT}")
    
   # create http request
   http = Net::HTTP.new(url.host, url.port)
   http.use_ssl = true

  # create request
  request = Net::HTTP::Get.new(url)
  request["accept"] = 'application/json'
  request["content-type"] = 'application/json'
  request["authorization"] = "Bearer #{ZELTY_ID_PRODUCTION}" 

  response = http.request(request)

    # Handle response
    if response.is_a?(Net::HTTPSuccess)
      products = JSON.parse(response.body)["dishes"]

      products.each do |product|
        product_id = product["id"] || "No id" if product_id.nil?
        product_name = product["name"] || "No name" if product_name.nil?
        product_description = product["description"] || "No description" if product_description.nil?
        product_price = product["price"].to_i / 100 || "No price" if product_price.nil?
        product_image = product["image"] || "https://res.cloudinary.com/dhcqyjeip/image/upload/v1688735231/Dwish/no_picture_aj42vi.jpg" if product_image.nil?
        product_thumbnail = product["thumb"] || "No thumbnail" if product_thumbnail.nil?  
        product_tax = product["tax"].to_i / 100 || "No tax" if product_tax.nil?
        product_tags = product["tags"] || "No tags" if product_tags.nil?
        product_meta = product["meta"] || "No meta" if product_meta.nil?
      end
    else
      puts "Error: #{response.message}"
    end

  end

  # Get all tags
  def self.getAllCategories

    url = URI("#{API_BASE_URL}#{TAGS_ENDPOINT}")

    # create http request
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    # configure request
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = "Bearer #{ZELTY_ID_PRODUCTION}" 

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      # Get all the data I need
      tags = JSON.parse(response.body)["tags"]

      tags.each do |tag|
        id = tag["id"] || "No id" if id.nil?
        name = tag["name"] || "No name" if name.nil?
        description = tag["description"] || "No description" if description.nil?
      end
    else
      puts "Error: #{response.message}"
    end
  end


end