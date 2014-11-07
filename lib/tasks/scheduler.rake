desc "update to tonzof"
task :update_feed => :environment do
  puts "Updating TonzOf Ftp..."
  Product.to_xlsx
  puts "done."
end
