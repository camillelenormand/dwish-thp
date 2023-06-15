# frozen_string_literal: true

class TitleComponent < ViewComponent::Base
  def initialize(title, options = {})
    @title = title
    @size = options[:size] || "h1"
    @class_name = options[:class_name] || ""
  end
   

  def call
    content_tag(@size, @title, class: @class_name)
  end
  
end
