require 'imgkit'
  require 'restclient'
  require 'stringio'
 
	kit = IMGKit.new(
	<<EOD
	<!DOCTYPE HTML>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>coolest converter</title>
  </head>
  <body>
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
EOD
)
IMGKit.configure do |config|
  config.wkhtmltoimage = 'c:\wkhtmltopdf\bin\wkhtmltoimage.exe'
end
    url='http://shopmitran.suresundar.com/assets/application.css.scss'
	css = StringIO.new( RestClient.get(url) )
	css.flush
	#kit.stylesheets << 'C:\learn\ROR\Roaring-ROR\app\assets\stylesheets\application.css.scss'
	kit.stylesheets << css
	# Get the image BLOB
	img = kit.to_img
