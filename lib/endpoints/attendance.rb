module Wonde
  class Attendance < Endpoints
    @@uri = 'attendance/session'
    def initialize(token, id = false, domain:)
      super(token, id, domain: domain)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = uri.gsub('//', '/').chomp('/')
    end

    def sessionRegister(register)
      throw InvalidSessionException unless register.instance_of?(SessionRegister)
      post(register)
    end
  end
end
