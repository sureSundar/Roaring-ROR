require 'restclient'
require 'stringio'
class CartsController < ApplicationController
  skip_before_action :authorize, only: [:create, :update, :destroy, :pub_social_cart]
  include CurrentCart
  before_action :self_set_cart, only: [:show, :edit, :update,:destroy]
  before_action :set_cart, only: [:destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cart }
      else
        format.html { render action: 'new' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
	puts "going to destory"
	puts @loc_cart.id
	#@loc_cart = Cart.find(params[:id])
	if @loc_cart.id == session[:cart_id]
		@cart.destroy 
		session[:cart_id] = nil
		respond_to do |format|
		  format.html { redirect_to store_url}
		  format.json { head :no_content }
		end	
	end
	if @loc_cart.id == session[:web_cart_id]
		@web_cart.destroy 
		session[:web_cart_id] = nil
		respond_to do |format|
		  format.html { redirect_to store_url}
		  format.json { head :no_content }
		end	
		
	end
	if @loc_cart.id == session[:soc_cart_id]
		@soc_cart.destroy 
		session[:soc_cart_id] = nil
		respond_to do |format|
		  format.html { redirect_to store_url}
		  format.json { head :no_content }
		end	
	end
	if @loc_cart.id == session[:wish_cart_id]
		@wish_cart.destroy 
		session[:wish_cart_id] = nil
		respond_to do |format|
		  format.html { redirect_to store_url}
		  format.json { head :no_content }
		end	
	end
  end
  def pub_social_cart
	kit = IMGKit.new(
	<<EOD
	<!DOCTYPE HTML>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
	<style type="text/css">
	#side {
	float: left;
	padding: 1em 2em;
	width: 13em;
	background: #141;
	form, div {
	display: inline;
	}
	#soc_cart {
	font-size: smaller;
	color: black;
	
	table {
	border-top: 1px dotted #595;
	border-bottom: 1px dotted #595;
	margin-bottom: 10px;
	}
	}
	</style>
    <title>coolest converter</title>
  </head>
  <body>
  <div id="side">			
	<div id="soc_cart">			
				<table>
		<tbody><tr>
<td>2x</td>
<td>SKIN CARE</td>
<td class="item_price">$4.00</td>
</tr>
<tr class="total_line">
<td colspan="2">Total</td>
	 <td class="total_cell">$4.00</td>
</tr>
</tbody></table>
</div>
</div>
EOD
)
    #url='http://shopmitran.suresundar.com/assets/application.css.scss'
	#css = StringIO.new( RestClient.get(url) )
	#css.flush
	#kit.stylesheets << 'C:\learn\ROR\Roaring-ROR\app\assets\stylesheets\application.css.scss'
	#puts css
	#kit.stylesheets << css
	# Get the image BLOB
	img = kit.to_img.force_encoding('UTF-8')
	#img.flush
	file = kit.to_file('c:\learn\ROR\Roaring-ROR\app\assets\images\home.jpg')
		respond_to do |format|
		  format.html { redirect_to store_url}
		  format.json { head :no_content }
		end	
	
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def self_set_cart
      @loc_cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params[:cart]
    end
    private
    def invalid_cart
	logger.error "Attempt to access invalid cart #{params[:id]}"
	redirect_to store_url, notice: 'Invalid cart'
    end
end
