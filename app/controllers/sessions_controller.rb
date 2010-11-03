require 'signet'
require 'signet/oauth_1/client'
#
require 'oauth'
require 'oauth/consumer'
require 'cgi'

class SessionsController < ApplicationController

=begin

App name = Hello world!
App ID = bfmkfbiemfopgnefghkmakgiaobhekhi
Access token scope = https://www.googleapis.com/auth/chromewebstore.readonly
oauth_signature_method = "HMAC-SHA1"
consumer_key = "anonymous"
consumer_secret = "anonymous"

oauth_token_secret = "AucIDnUTzP8le3AHiwl/RTPJ"
oauth_token = "1/6H9A-UenyD1WJY_vBxBcosH7X3UAsaqCDtewx_BUb2A"


=end
  Token = "1/6H9A-UenyD1WJY_vBxBcosH7X3UAsaqCDtewx_BUb2A"
  TokenSecret = "AucIDnUTzP8le3AHiwl/RTPJ"

  ConsumerKey = "anonymous"
  ConsumerSecret = "anonymous"
  
  Scope = "https://www.googleapis.com/auth/chromewebstore.readonly" 
  AppID = "bfmkfbiemfopgnefghkmakgiaobhekhi"
  Url = "https://www.googleapis.com/chromewebstore/v1/licenses/%s/%s"

  FullUser = "AItOawmWpkMt_qJRVRQfIlJ32TZnW1mmzYbjWeI"
  FreeUser = "AItOawlh_ZYIBQi-kNV-d3Rd8WIjQEBsLDh5LDQ"
  FullUser1 = "https://www.google.com/accounts/o8/id?id=AItOawmWpkMt_qJRVRQfIlJ32TZnW1mmzYbjWeI"
  FreeUser2 = "https://www.google.com/accounts/o8/id?id=AItOawlh_ZYIBQi-kNV-d3Rd8WIjQEBsLDh5LDQ"

  def index
    if request.env['rack.openid.response']
      res = request.env['rack.openid.response']
      case res.status
      when :success
        p 'success'

uri = Url%[AppID,CGI::escape(FullUser1)]

=begin
p uri
cc = OAuth::Consumer.new(ConsumerKey, 
                         ConsumerSecret,
                         {:signature_method => 'HMAC-SHA1'})

cb = OAuth::AccessToken.new(cc,Token,TokenSecret)

resp = cb.get(uri)

p resp.body
=end

#=begin
p uri
client = Signet::OAuth1::Client.new(
  :client_credential_key => ConsumerKey,
  :client_credential_secret => ConsumerSecret
)
client.access_token_key = Token
client.access_token_secret = TokenSecret

resp= client.fetch_protected_resource(
  :uri => uri
)
status, headers, body = resp
p body
#=end


      when :failed
        p 'failed'
      when :missing
        p 'missing'
      end
    else
      response.headers[Rack::OpenID::AUTHENTICATE_HEADER] = "OpenID identifier=\"http://www.google.com/accounts/o8/id\""
      head :unauthorized
    end
  end
end
