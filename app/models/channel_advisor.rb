class ChannelAdvisor
	include HTTParty
	
	
	base_uri 'api.channeladvisor.com'
	
	def initialize()
		@options = { "Header" => {"APICredentials" => {'DeveloperKey' => ENV['channeladvisor_developer_key'], 'Password' => ENV['channeladvisor_password']}}, query: {site: "GetInventoryQuantity",'accountID' => ENV['channeladvisor_account_id'], 'sku' => "ACC-1"}}
	end

	def get_inventory_quantity
		self.class.post("/InventoryService.asmx?WSDL",@options)
	end
end
