class Product < ActiveRecord::Base

def self.update_inventory 
	kits=SkuVault.new.get_kit_quantities
	Product.all.each do |p|
		p.update_attributes(inventory: kits[p.sku])
	end
end

end
