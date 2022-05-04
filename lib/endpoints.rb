module Wonde
  # Top level Endpoints class, most of our classes inherit from this
  # Some methods use this directly
  class Endpoints
    require 'rest-client'
    require 'ostruct'
    require 'addressable/uri'
    require 'json'
    attr_accessor :endpoint, :uri, :token, :version

    def initialize(token, uri = false, domain:)
      self.endpoint = "https://#{domain}/v1.0/"
      self.uri = String.new
      self.version = '0.0.1'
      self.token = token
      self.uri = uri if uri
    end

    # Forwards request info, eventually to unirest
    #
    # @param endpoint [String]
    # @return [Object]
    def getRequest(endpoint)
      puts 'self.endpoint: ' + self.endpoint if ENV['debug_wonde']
      puts 'endpoint:' + endpoint if ENV['debug_wonde']
      getUrl(self.endpoint + endpoint)
    end

    # Forwards request info to unirest
    #
    # @param url [String]
    # @return [Object]
    def getUrl(url)
      RestClient::Request.execute(
        method: :get,
        url: url,
        headers: {
          'Authorization' => "Bearer #{token}",
          'User-Agent' => "wonde-rb-client-#{version}"
        }
      )
    end

    # Builds get request and passes it along
    #
    # @param id [String]
    # @param includes [Hash]
    # @param parameters [Hash]
    # @return [Object]
    def get(id, includes = {}, parameters = {})
      parameters['include'] = includes.join(',') unless includes.nil? or includes.empty?
      if parameters.empty?
        uri = self.uri + id
      else
        uriparams = Addressable::URI.new
        uriparams.query_values = parameters
        uri = self.uri + id + '?' + uriparams.query
      end
      response = getRequest(uri).body
      puts response if ENV['debug_wonde']
      object = JSON.parse(response, object_class: OpenStruct)
      puts object if ENV['debug_wonde']
      object.data
    end

    def postRequest(endpoint, body = {})
      puts "self.endpoint:\n " + self.endpoint if ENV['debug_wonde']
      puts "endpoint:\n" + endpoint if ENV['debug_wonde']
      puts "body:\n" + body.to_json if ENV['debug_wonde']
      postUrl(self.endpoint + endpoint, body)
    end

    def postUrl(url, body = {})
      puts body.to_json if ENV['debug_wonde']
      RestClient::Request.execute(
        method: :post,
        url: url,
        headers: {
          'Authorization' => "Basic #{token}",
          'User-Agent' => "wonde-rb-client-#{version}",
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        },
        payload: body.to_json
      )
    end

    def post(body = {})
      hash_response = JSON.parse(postRequest(uri, body).body)
      return {} if hash_response.nil?

      OpenStruct.new hash_response
    end

    def deleteRequest(endpoint, body = {})
      puts 'self.endpoint: ' + self.endpoint if ENV['debug_wonde']
      puts 'endpoint:' + endpoint if ENV['debug_wonde']
      puts 'body:' + body.to_json if ENV['debug_wonde']
      deleteUrl(self.endpoint + endpoint, body)
    end

    def deleteUrl(url, body = {})
      puts body.to_json if ENV['debug_wonde']
      RestClient::Request.execute(
        method: :delete,
        url: url,
        headers: {
          'Authorization' => "Basic #{token}",
          'User-Agent' => "wonde-rb-client-#{version}",
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        },
        payload: body.to_json
      )
    end

    def delete(body = {})
      hash_response = deleteRequest(uri, body).body
      return {} if hash_response.nil?

      OpenStruct.new hash_response
    end

    def all(includes = [], parameters = {})
      parameters['include'] = includes.join(',') unless includes.nil? or includes.empty?

      if parameters.nil? or parameters.empty?
        uri = self.uri
      else
        uriparams = Addressable::URI.new
        uriparams.query_values = parameters
        uriparams.query
        uri = self.uri + '?' + uriparams.query
      end
      response = getRequest(uri).body
      puts response if ENV['debug_wonde']
      object = JSON.parse(response, object_class: OpenStruct)
      puts object if ENV['debug_wonde']
      ResultIterator.new(object, token)
    end
  end
end
