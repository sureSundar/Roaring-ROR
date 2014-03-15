require 'fb_graph'

# setup client
fb_auth = FbGraph::Auth.new('1399321243667774', 'c9c53090e7f8645965460e640f6b2215')
fb_auth.exchange_token! 'short-life-access-token'
fb_auth.access_token # => Rack::OAuth2::AccessToken

# setup client
client = fb_auth.client
client.redirect_uri = "http://shopmitran.suresundar.com/"

# redirect user to facebook
redirect_to client.authorization_uri(
  :scope => [:email, :read_stream, :offline_access]
)

# in callback
client.authorization_code = params[:code]
access_token = client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
FbGraph::User.me(access_token).fetch # => FbGraph::User