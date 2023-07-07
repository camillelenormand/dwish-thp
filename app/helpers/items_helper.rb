module ItemsHelper
  include ZeltyService

  # Match category names with category ids

  def retrieve_category_names(categories_data, products_data)

    if categories_data.nil? || products_data.nil?
      raise ArgumentError, "categories_data and products_data cannot be nil"
    end

    puts "categories_data: #{categories_data}"
    puts "products_data: #{products_data}"
    
    category_names = {}

    categories_data.each do |tag|
      category_names[tag["id"]] = tag["name"]
      puts "category_names: #{category_names}"
    end

    @product_category_names = []

    products_data.each do |dish|
      dish["tags"].each do |category_id|
        category_name = category_names[category_id]
        puts "category_name: #{category_name}"
        @product_category_names << { tag_id: category_id, tag_name: category_name } if category_name
        puts "product_category_names: #{@product_category_names}"
      end
    end

    @product_category_names.uniq.sort_by { |category| category[:tag_name] }
    puts "product_category_names: #{@product_category_names}"
  end

  # Filter by category in views
          
end
