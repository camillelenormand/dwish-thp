class CategoriesUpsertJob < ApplicationJob
  queue_as :default

  def perform(*args)

    categories = ZeltyService.getAllCategories

    categories.each do |category|
      category_id = category["id"] || "No id" if category_id.nil?
      puts "category_id: #{category_id}"
      category_name = category["name"] || "No name" if category_name.nil?
      puts "category_name: #{category_name}"
      category_description = category["description"] || "No description" if category_description.nil?
      puts "category_description: #{category_description}"

      update_or_create_category(category_id, category_name, category_description)
    end
  end

  private

  def update_or_create_category(zelty_id, name, description)
    category = Category.find_or_initialize_by(zelty_id: zelty_id)
    return puts "Category not found" unless category

    category.update!(
      name: name,
      description: description,
      zelty_id: zelty_id
    )

    puts "Category updated"
  end

end
