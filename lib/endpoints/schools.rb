module Wonde
  class Schools < Endpoints
    attr_accessor :uri, :achievements, :attendance, :behaviours, :classes,
                  :contacts, :counts, :employees, :groups, :lessons,
                  :lessonAttendance, :medicalConditions, :medicalEvents,
                  :medicalNotes, :periods, :photos, :rooms, :subjects, :students,
                  :assessment, :deletions, :events, :attendanceSummaries
    @@uri = 'schools/'
    def initialize(token, id=false, domain:)
      super(token, id, domain: domain)
      self.token = token
      self.uri = @@uri
      self.uri = @@uri + id + '/' if id
      self.uri = self.uri.gsub("//", "/").chomp("/")
      self.achievements        = Wonde::Achievements.new(token, self.uri, domain: domain)
      self.assessment          = Wonde::Assessment.new(token, self.uri, domain: domain)
      self.attendance          = Wonde::Attendance.new(token, self.uri, domain: domain)
      self.behaviours          = Wonde::Behaviours.new(token, self.uri, domain: domain)
      self.classes             = Wonde::Classes.new(token, self.uri, domain: domain)
      self.contacts            = Wonde::Contacts.new(token, self.uri, domain: domain)
      self.counts              = Wonde::Counts.new(token, self.uri, domain: domain)
      self.deletions           = Wonde::Deletions.new(token, self.uri, domain: domain)
      self.employees           = Wonde::Employees.new(token, self.uri, domain: domain)
      self.events              = Wonde::Events.new(token, self.uri, domain: domain)
      self.groups              = Wonde::Groups.new(token, self.uri, domain: domain)
      self.lessons             = Wonde::Lessons.new(token, self.uri, domain: domain)
      self.lessonAttendance    = Wonde::LessonAttendance.new(token, self.uri, domain: domain)
      self.attendanceSummaries = Wonde::AttendanceSummaries.new(token, self.uri, domain: domain)
      self.medicalConditions   = Wonde::MedicalConditions.new(token, self.uri, domain: domain)
      self.medicalEvents       = Wonde::MedicalEvents.new(token, self.uri, domain: domain)
      self.medicalNotes        = Wonde::MedicalNotes.new(token, self.uri, domain: domain)
      self.periods             = Wonde::Periods.new(token, self.uri, domain: domain)
      self.photos              = Wonde::Photos.new(token, self.uri, domain: domain)
      self.rooms               = Wonde::Rooms.new(token, self.uri, domain: domain)
      self.students            = Wonde::Students.new(token, self.uri, domain: domain)
      self.subjects            = Wonde::Subjects.new(token, self.uri, domain: domain)
    end

    def pending(includes = Array.new(), parameters = Array.new())
      self.uri = @@uri + 'pending/'
      return self.all(includes, parameters)
    end

    def search(includes = Hash.new(), parameters = Hash.new())
        self.uri = @@uri + 'all/'
        return self.all(includes, parameters)
    end

    def get(id, includes = Array.new(), parameters = Array.new())
        self.uri = @@uri
        school = super(id, includes, parameters)
        return school
    end

  end
end
