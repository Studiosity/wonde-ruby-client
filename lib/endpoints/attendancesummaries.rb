module Wonde
  class AttendanceSummaries < Endpoints
    @@uri = 'attendance-summaries/'
    def initialize(token, id=false, domain:)
      super(token, id, domain: domain)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
    end
  end
end
