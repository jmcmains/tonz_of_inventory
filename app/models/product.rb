class Product < ActiveRecord::Base

def self.update_inventory 
	kits=SkuVault.new.get_kit_quantities
	aliases = {"PUB-1" => "BAN-001 01","PUB-2" => "BAN-002 01","PUB-3" => "BAN-003 01","PUB-4" => "BAN-004 01","PUB-5" => "BAN-005 01","PUB-6" => "BAN-006 01","PUB-8" => "BAN-008 01","PUB-9" => "BAN-009 01"}
	Product.all.each do |p|
		if kits[p.sku].blank?
			kits[p.sku]=SkuVault.new.get_item_quantity(aliases[p.sku])
		end
		p.update_attributes(inventory: kits[p.sku])
	end
end

def update_inventory
	count=SkuVault.new.get_kit_quantity(sku)
	if count.blank?
		aliases = {"PUB-1" => "BAN-001 01","PUB-2" => "BAN-002 01","PUB-3" => "BAN-003 01","PUB-4" => "BAN-004 01","PUB-5" => "BAN-005 01","PUB-6" => "BAN-006 01"}
		count=SkuVault.new.get_item_quantity(aliases[sku])
	end
	update_attributes(inventory: count)
end

def self.to_xlsx
	require 'net/ftp'
	require 'stringio'
	Product.update_inventory
	xlsx=CSV.generate(col_sep: "\t") do |csv|
		csv << ["Company Name: Rubberbanditz"]
		csv << ["Vendor Part Number (VPN)","Current Cost","Quantity Available for Sale"]
		Product.all.each do |product|
			csv << [product.sku, product.wholesale_price, product.inventory]
		end
	end
	file ='prices.xlsx'
	ftp = Net::FTP.new('feeds.tonzof.com')
	ftp.passive = true
	ftp.login(ENV["tonzof_user"],ENV["tonzof_pass"])
	ftp.storbinary("STOR " + file, StringIO.new(xlsx),1024)
	ftp.close
	
end

end
