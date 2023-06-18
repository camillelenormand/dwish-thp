# frozen_string_literal: true

class CartButtonComponent < ViewComponent::Base
  def initialize(cart_size:, icon:, url:, style: )
    @cart_size = cart_size
    @icon = icon
    @url = url
    @style = style
  end
end
