class Product < ActiveRecord::Base

def self.update_inventory 
	kits=SkuVault.new.get_kit_quantities
	aliases = {"PUB-1" => "BAN-001 01","PUB-2" => "BAN-002 01","PUB-3" => "BAN-003 01","PUB-4" => "BAN-004 01","PUB-5" => "BAN-005 01","PUB-6" => "BAN-006 01"}
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

end
