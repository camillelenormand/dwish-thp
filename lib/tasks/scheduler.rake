include Rake::DSL if defined?(Rake::DSL)
include CategoriesUpsertJob 
include ItemsUpsertJob

desc "This task is called by the Heroku scheduler add-on"
task :update_categories => :environment do
  puts "Updating categories..."
  CategoriesUpsertJob.perform_now
  puts "done."
end

task :update_items => :environment do
  puts "Updating items..."
  ItemsUpsertJob.perform_now
  puts "done."
end