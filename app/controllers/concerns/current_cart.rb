module CurrentCart
	extend ActiveSupport::Concern
	private
	def set_cart
		@cart = Cart.find(session[:cart_id])
		@wish_cart = Cart.find(session[:wish_cart_id])		
		@web_cart = Cart.find(session[:web_cart_id])
		@soc_cart = Cart.find(session[:soc_cart_id])
		
	rescue ActiveRecord::RecordNotFound
		if (session[:cart_id] == nil)
			@cart = Cart.create
			session[:cart_id] = @cart.id
		end
		if (session[:wish_cart_id] == nil)
			@wish_cart = Cart.create
			session[:wish_cart_id] = @wish_cart.id
		end
		if (session[:web_cart_id] == nil)
			@web_cart = Cart.create
			session[:web_cart_id] = @web_cart.id
		end
		if (session[:soc_cart_id] == nil)
			@soc_cart = Cart.create
			session[:soc_cart_id] = @soc_cart.id
		end
	end
end