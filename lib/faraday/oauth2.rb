require 'faraday'

# @private
module Faraday
  # @private
  class Request::OAuth2 < Faraday::Middleware
    def call(env)

      if env[:method] == :get or env[:method] == :delete
        env[:url].query_values = {} if env[:url].query_values.nil?
        if @access_token and not env[:url].query_values["client_secret"]
          env[:url].query_values = env[:url].query_values.merge(:access_token => @access_token)
          env[:request_headers] = env[:request_headers].merge('Authorization' => "Token token=\"#{@access_token}\"")
        elsif @client_id
          env[:url].query_values = env[:url].query_values.merge(:client_id => @client_id)
        end
      else
        if @access_token and not env[:body] && env[:body][:client_secret]
          env[:body] = {} if env[:body].nil?
          env[:body] = env[:body].merge(:access_token => @access_token)
          env[:request_headers] = env[:request_headers].merge('Authorization' => "Token token=\"#{@access_token}\"")
        elsif @client_id
          env[:body] = env[:body].merge(:client_id => @client_id)
        end
      end

      env[:body] = set_form_data(env[:body]) if env[:body].instance_of?(Hash)

      @app.call env
    end

    def initialize(app, client_id, access_token=nil)
      @app = app
      @client_id = client_id
      @access_token = access_token
    end

    def set_form_data(params, sep = '&')
      params.map {|k, v| encode_kvpair(k, v) }.flatten.join(sep)
    end

    def encode_kvpair(k, vs)
      Array(vs).map {|v| "#{urlencode(k.to_s)}=#{urlencode(v.to_s)}" }
    end

    def urlencode(str)
      str.dup.force_encoding('ASCII-8BIT').gsub(/[^a-zA-Z0-9_\.\-]/){'%%%02x' % $&.ord}
    end
  end
end
