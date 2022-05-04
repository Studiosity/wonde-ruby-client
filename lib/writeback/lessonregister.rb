module Wonde
  class LessonRegister
    attr_accessor :attendance

    def initialize
      self.attendance = []
    end

    def to_json(*_args)
      { 'attendance' => [attendance] }.to_json
    end

    def add(lessonAttendance)
      newlessonattendance = []
      newlessonattendance.push(lessonAttendance)
      newlessonattendance.each do |lessonAttendanceSingular|
        if lessonAttendanceSingular.instance_of?(LessonAttendanceRecord) && lessonAttendanceSingular.isValid
          self.attendance = lessonAttendanceSingular.toArray
        else
          unless lessonAttendanceSingular.instance_of?(LessonAttendanceRecord)
            throw InvalidLessonAttendanceException, 'Attendance is not an instance of the LessonAttendance Class.'
          end
          throw InvalidLessonAttendanceException, 'Attendance has empty fields.' unless lessonAttendanceSingular.isValid
          throw InvalidLessonAttendanceException
        end
      end
    end
  end
end
