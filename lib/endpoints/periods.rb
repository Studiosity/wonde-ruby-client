module Wonde
  class Periods < Endpoints
    @@uri = 'periods/'
    def initialize(token, id = false, domain:)
      super(token, id, domain: domain)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = uri.gsub('//', '/').chomp('/')
    end
  end
end
