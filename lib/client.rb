require 'pp'
# Main Module/Namespace to hold all the Wonde classes
#
module Wonde
  # Main client class that the user will interface with
  #
  # @param token [String]
  # @return [Object]
  #
  # @example
  #   require 'wondeclient'
  #   client = Wonde::Client.new('TOKEN_GOES_HERE')
  #   client.schools.all().each do |school|
  #     p school.name
  #   end
  class Client
    REGION_DOMAIN_LOOKUP = {
      australia: 'api-ap-southeast-2.wonde.com'
    }.freeze
    REST_OF_WORLD_DOMAIN = 'api.wonde.com'.freeze

    attr_accessor :schools, :attendanceCodes, :token, :domain
    @@attendanceCodes
    @@token
    @@version = '0.0.6'
    # Initialize a Client Object
    #
    # @param token [String] Wonde API token
    # @param region [Symbol] Either :rest_of_world (default) or :australia
    # @return [Object]
    #
    # @example
    #   Wonde::Client.new("SOMETOKEN") #=> #<Wonde::Client:0x007fb223953da0 @token="SOMETOKEN">
    #   Wonde::Client.new("SOMETOKEN", region: :australia) #=> #<Wonde::Client:0x007fb223953da0 @token="SOMETOKEN">
    def initialize(token, region: :rest_of_world)
      @@token = token
      @domain = REGION_DOMAIN_LOOKUP[region] || REST_OF_WORLD_DOMAIN
      @token = token
      @schools = Wonde::Schools.new(token, domain: domain)
      @attendanceCodes = Wonde::AttendanceCodes.new(token, domain: domain)
    end

    # Get School/Schools Object
    #
    # @param id [String]
    # @return [Object]
    #
    # @example
    #   client = Wonde::Client.new("SOMETOKEN")
    #   school = client.school('SCHOOLID')
    def school(id)
      Wonde::Schools.new(token, id, domain: domain)
    end

    # requestAccess endpoint POST
    #
    # @param schoolId [String]
    # @return [Object]
    #
    # @example
    #   client = Wonde::Client.new("SOMETOKEN")
    #   client.requestAccess("A0000000000")
    def requestAccess(schoolId)
      Wonde::Endpoints.new(token, ('schools/' + schoolId + '/request-access'), domain: domain).post()
    end

    # revokeAccess endpoint DELETE
    #
    # @param schoolId [String]
    # @return [Object]
    #
    # @example
    #   client = Wonde::Client.new("SOMETOKEN")
    #   client.revokeAccess('A0000000000')
    def revokeAccess(schoolId)
      Wonde::Endpoints.new(token, ('schools/' + schoolId + '/revoke-access'), domain: domain).delete()
    end

  end
end
