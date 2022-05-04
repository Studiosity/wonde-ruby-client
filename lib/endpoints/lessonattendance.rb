module Wonde
  class LessonAttendance < Endpoints
    @@uri = 'attendance/lesson/'
    def initialize(token, id = false, domain:)
      super(token, id, domain: domain)
      self.uri = @@uri
      self.uri = id + '/' + @@uri if id
      self.uri = uri.gsub('//', '/').chomp('/')
    end

    def lessonRegister(register)
      throw InvalidSessionException unless register.instance_of?(LessonRegister)
      post(register)
    end
  end
end
