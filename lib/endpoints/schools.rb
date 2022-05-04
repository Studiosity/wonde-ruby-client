module Wonde
  class Schools < Endpoints
    attr_accessor :uri, :achievements, :attendance, :behaviours, :classes,
                  :contacts, :counts, :employees, :groups, :lessons,
                  :lessonAttendance, :medicalConditions, :medicalEvents,
                  :medicalNotes, :periods, :photos, :rooms, :subjects, :students,
                  :assessment, :deletions, :events, :attendanceSummaries

    @@uri = 'schools/'
    def initialize(token, id = false, domain:)
      super(token, id, domain: domain)
      self.token = token
      self.uri = @@uri
      self.uri = @@uri + id + '/' if id
      self.uri = uri.gsub('//', '/').chomp('/')
      self.achievements        = Wonde::Achievements.new(token, uri, domain: domain)
      self.assessment          = Wonde::Assessment.new(token, uri, domain: domain)
      self.attendance          = Wonde::Attendance.new(token, uri, domain: domain)
      self.behaviours          = Wonde::Behaviours.new(token, uri, domain: domain)
      self.classes             = Wonde::Classes.new(token, uri, domain: domain)
      self.contacts            = Wonde::Contacts.new(token, uri, domain: domain)
      self.counts              = Wonde::Counts.new(token, uri, domain: domain)
      self.deletions           = Wonde::Deletions.new(token, uri, domain: domain)
      self.employees           = Wonde::Employees.new(token, uri, domain: domain)
      self.events              = Wonde::Events.new(token, uri, domain: domain)
      self.groups              = Wonde::Groups.new(token, uri, domain: domain)
      self.lessons             = Wonde::Lessons.new(token, uri, domain: domain)
      self.lessonAttendance    = Wonde::LessonAttendance.new(token, uri, domain: domain)
      self.attendanceSummaries = Wonde::AttendanceSummaries.new(token, uri, domain: domain)
      self.medicalConditions   = Wonde::MedicalConditions.new(token, uri, domain: domain)
      self.medicalEvents       = Wonde::MedicalEvents.new(token, uri, domain: domain)
      self.medicalNotes        = Wonde::MedicalNotes.new(token, uri, domain: domain)
      self.periods             = Wonde::Periods.new(token, uri, domain: domain)
      self.photos              = Wonde::Photos.new(token, uri, domain: domain)
      self.rooms               = Wonde::Rooms.new(token, uri, domain: domain)
      self.students            = Wonde::Students.new(token, uri, domain: domain)
      self.subjects            = Wonde::Subjects.new(token, uri, domain: domain)
    end

    def pending(includes = [], parameters = [])
      self.uri = @@uri + 'pending/'
      all(includes, parameters)
    end

    def search(includes = {}, parameters = {})
      self.uri = @@uri + 'all/'
      all(includes, parameters)
    end

    def get(id, includes = [], parameters = [])
      self.uri = @@uri
      super(id, includes, parameters)
    end
  end
end
