module Wonde
  class AttendanceCodes < Endpoints
    @@uri = 'attendance-codes/'
    def initialize(token, id = false, domain:)
      super(token, id, domain: domain)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = uri.gsub('//', '/').chomp('/')
    end
  end
end
