require 'httpclient'

class StoreController < ApplicationController
skip_before_action :authorize
include CurrentCart
before_action :set_cart

  def index
	if params[:set_locale]
		redirect_to store_url(locale: params[:set_locale])
	else
		Product.save_data_from_api(params[:srch])
		search_condition="%%"
		if (params[:srch] != nil)
			search_condition = "%" + params[:srch] + "%"
		end
		@products = Product.find(:all, :conditions => ['title LIKE ? OR description LIKE ?', search_condition, search_condition])
	end
  end
  def stg_index
	if params[:set_locale]
		redirect_to store_url(locale: params[:set_locale])
	else
		#srch_var="CEREAL"
		#search_url="https://nielsen.api.tibco.com:443/Products/v1/?search=#{srch_var}&apikey=3688-de41c79d-35fd-4b04-8089-783ce52be3d5"
		#prod_url="https://nielsen.api.tibco.com:443/Products/v1/?search=#{upc_var}&apikey=3688-de41c79d-35fd-4b04-8089-783ce52be3d5"
		#response = fetchURL(search_url)
		#@products = getJSONObject(response)
		@products = JSON.parse('{
  "Header":{
    "API_Version":"1.0",
    "API_Name":"Product Search",
    "Content_Type":"JSON",
    "Message_ID":"39314",
    "Date":"2014-03-11T11:42:12.529-04:00"
  },
  "ProductDetails":[
    {
      "UPC":"0072151461207",
      "Description":"FREEMAN ULTRA HAND CARE HAND AND NAIL LOTION LOTION  TUBE 5.3 FLUID OUNCE",
      "Item_Code":"530516480",
      "Module":"SKIN CARE",
      "Rank":"1"
    },
    {
      "UPC":"0072151461221",
      "Description":"FREEMAN ULTRA HAND CARE HAND THERAPY LOTION  TUBE 5.3 FLUID OUNCE",
      "Item_Code":"1731921920",
      "Module":"SKIN CARE",
      "Rank":"2"
    },
    {
      "UPC":"0072151461245",
      "Description":"FREEMAN ULTRA HAND CARE HAND AND NAIL LOTION LOTION  TUBE 1 FLUID OUNCE",
      "Item_Code":"12264960",
      "Module":"SKIN CARE",
      "Rank":"3"
    },
    {
      "UPC":"0094187027837",
      "Description":"JERGENS ULTRA HEALING HAND AND BODY AND SKIN PRODUCT LOTION  TUBE IN BOX 1 FLUID OUNCE",
      "Item_Code":"924672513",
      "Module":"SKIN CARE",
      "Rank":"4"
    },
    {
      "UPC":"0019045027019",
      "Description":"CUREL ULTRA HEALING HAND AND BODY AND SKIN PRODUCT LOTION FRAGRANCE FREE TUBE 1 FLUID OUNCE",
      "Item_Code":"1804163585",
      "Module":"SKIN CARE",
      "Rank":"5"
    },
    {
      "UPC":"0019045105397",
      "Description":"CUREL ULTRA HEALING HAND AND BODY AND SKIN PRODUCT LOTION  TUBE 2.5 FLUID OUNCE",
      "Item_Code":"1345327618",
      "Module":"SKIN CARE",
      "Rank":"6"
    },
    {
      "UPC":"0019045105427",
      "Description":"CUREL ULTRA HEALING HAND AND BODY AND SKIN PRODUCT LOTION  BOTTLE 20 FLUID OUNCE",
      "Item_Code":"942936578",
      "Module":"SKIN CARE",
      "Rank":"7"
    },
    {
      "UPC":"0019045105410",
      "Description":"CUREL ULTRA HEALING HAND AND BODY AND SKIN PRODUCT LOTION  BOTTLE 13 FLUID OUNCE",
      "Item_Code":"942674434",
      "Module":"SKIN CARE",
      "Rank":"8"
    },
    {
      "UPC":"0019045105403",
      "Description":"CUREL ULTRA HEALING HAND AND BODY AND SKIN PRODUCT LOTION  TUBE 6 FLUID OUNCE",
      "Item_Code":"3150338",
      "Module":"SKIN CARE",
      "Rank":"9"
    },
    {
      "UPC":"0070596009800",
      "Description":"ULTRA GLOW HAND AND BODY AND SKIN PRODUCT LIQUID  JAR 1.8 OUNCE",
      "Item_Code":"280532994",
      "Module":"SKIN CARE",
      "Rank":"10"
    }
  ],
  "Summary":{
    "PageNo":"1",
    "PageSize":"10",
    "TotalPages":"1733",
    "TotalRecords":"17327"
  }
}')
	@products["ProductDetails"].each do |product|
				p product["Description"]
			end
	end
  end
  def fetchURL(url)
	puts "URL : #{url}"
	http = HTTPClient.new	
	response = http.get_content(url)
	puts response	
	return response
  end
  def getJSONObject(input)
	json = JSON.parse(input)
	return json	
  end

end
