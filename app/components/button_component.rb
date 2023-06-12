# frozen_string_literal: true
class ButtonComponent < ViewComponent::Base
  def initialize(label: , url: , style: "primary", size: "md")
    @label = label
    @style = style
    @url = url
    @size = size
  end

end
