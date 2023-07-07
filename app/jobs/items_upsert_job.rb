class ItemsUpsertJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # Get all items from Zelty
    items = ZeltyService.getAllProducts

    items.each do |item|
      item_id = item["id"] || "No id" if item_id.nil?
      puts "item_id: #{item_id}"
      item_name = item["name"] || "No name" if item_name.nil?
      puts "item_name: #{item_name}"
      item_description = item["description"] || "No description" if item_description.nil?
      puts "item_description: #{item_description}"
      item_price = item["price"].to_i / 100 || "No price" if item_price.nil?
      puts "item_price: #{item_price}"
      item_image = item["image"] || "No image" if item_image.nil?
      puts "item_image: #{item_image}"
      item_tax = item["tax"].to_i / 100 || "No tax" if item_tax.nil?
      puts "item_tax: #{item_tax}"
      item_tags = item["tags"] || "No tags" if item_tags.nil?
      puts "item_tags: #{item_tags}"

      update_or_create_item(item_name, item_description, item_price, item_image, item_id, item_tags)
    end
  end

  private

  def update_or_create_item(name, description, price, image_url, zelty_id, tags)
    item = Item.find_or_initialize_by(zelty_id: zelty_id)
    return puts "Item not found" unless item

    item.update!(
      name: name,
      description: description,
      price: price,
      image_url: image_url,
      zelty_id: zelty_id,
      category_id: Category.find_or_create_by(zelty_id: tags).id
    )

    puts "Item updated" if item && item.persisted? && item.valid? && item.saved_change_to_id?
    puts "Item created" if item && item.persisted? && item.valid? && item.new_record?

  end

end
