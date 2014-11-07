class SkuVault
	include HTTParty
	
	headers 'Accept' => 'application/json'
	
	def initialize()
		@options = { query: {"pageNumber" => 0, "tenantToken" => ENV["tenant_token"], "userToken" => ENV["user_token"], "WarehouseId" => ENV["warehouse_id"]} }
	end

	def get_item_quantities
		kits=self.class.post("https://app.skuvault.com/api/inventory/getItemQuantities", @options).parsed_response["Items"]
		k2=kits.inject({}) do |s,q|
			s.merge!({q["Sku"] => q["AvailableQuantity"]})
		end
	end
	
	def get_kit_quantities
		kits=self.class.post("https://app.skuvault.com/api/inventory/getKitQuantities", @options).parsed_response["Kits"]
		k2=kits.inject({}) do |s,q|
			s.merge!({q["Sku"] => q["AvailableQuantity"]})
		end
	end
	
	def get_kit_quantity(sku)
		k2=self.get_kit_quantities
		return k2[sku]
	end
	
	def get_items
		products=self.class.post("https://app.skuvault.com/api/products/getProducts", @options).parsed_response["Products"]
		k2=products.inject({}) do |s,q|
			s.merge!({q["Sku"] => q})
		end
	end
	
	def get_item_quantity(sku)
		@options[:query]["Sku"]= sku
		self.class.post("https://app.skuvault.com/api/inventory/GetWarehouseItemQuantity", @options).parsed_response["TotalQuantityOnHand"]
	end

end
