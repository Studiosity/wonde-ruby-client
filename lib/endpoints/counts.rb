module Wonde
  class Counts < Endpoints
    @@uri = 'counts/'
    def initialize(token, id = false, domain:)
      super(token, id, domain: domain)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = uri.gsub('//', '/').chomp('/')
    end
  end
end
