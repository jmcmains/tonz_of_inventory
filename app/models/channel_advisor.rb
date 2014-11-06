class ChannelAdvisor
	include HTTParty
	
	
	base_uri 'https://api.channeladvisor.com/ChannelAdvisorAPI/v7/InventoryService.asmx?WSDL'
	
	def initialize()
		@options = { headers: {'DeveloperKey' => ENV['channeladvisor_developer_key'], 'Password' => ENV['channeladvisor_password']}, query: {'accountID' => ENV['channeladvisor_account_id'], 'sku' => "ACC-1"} }
	end

	def get_inventory_quantity
		self.class.post("GetInventoryQuantity",@options)
	end
end
