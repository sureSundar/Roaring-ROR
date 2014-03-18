class Product < ActiveRecord::Base
        has_many :orders, through: :line_items
	has_many :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :upc, uniqueness: true
	validates :image_url, allow_blank: true, format: {
	with: %r{\.(gif|jpg|png)\Z}i,
	message: 'must be a URL for GIF, JPG or PNG image.'
	}
	def self.latest
		#save_data_from_api
		Product.order(:updated_at).last
	end

	private
	# ensure that there are no line items referencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
		end
	end
	# optional, but probably a good idea
    def self.save_data_from_api(srch_var)
	
		#srch_var="CEREAL"
		if (srch_var != nil)
			#Product.delete_all
			search_url="https://nielsen.api.tibco.com:443/Products/v1/?search=#{srch_var}&apikey=3688-de41c79d-35fd-4b04-8089-783ce52be3d5"
			#prod_url="https://nielsen.api.tibco.com:443/Products/v1/?search=#{upc_var}&apikey=3688-de41c79d-35fd-4b04-8089-783ce52be3d5"
			response = self.fetchURL(search_url)
			products = self.getJSONObject(response)
			users = products['ProductDetails'].map do |line|
			  u = Product.new
			  u.title = line['Module']
			  u.description = line['Description']
			  u.price = line['Rank']
			  u.image_url='rails.png'
			  u.upc = line['UPC']
			  # set name value however you want to do that
			  u.save
			  u
			end
			users.select(&:persisted?)
		end
	end
	def self.fetchURL(url)
		puts "URL : #{url}"
		http = HTTPClient.new	
		response = http.get_content(url)
		puts response	
		return response
	end
	def self.getJSONObject(input)
		json = JSON.parse(input)
		return json	
	end	
end
