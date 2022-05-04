module Wonde
  class SessionRegister
    attr_accessor :attendance

    def initialize
      self.attendance = []
    end

    def to_json(*_args)
      { 'attendance' => [attendance] }.to_json
    end

    def add(attendance)
      newattendance = []
      newattendance.push(attendance)
      newattendance.each do |attendanceSingular|
        if attendanceSingular.instance_of?(SessionAttendanceRecord) && attendanceSingular.isValid
          self.attendance = attendanceSingular.toArray
        else
          unless attendanceSingular.instance_of?(SessionAttendanceRecord)
            throw InvalidAttendanceException, 'Attendance is not an instance of the Attendance Class.'
          end
          throw InvalidAttendanceException, 'Attendance has empty fields.' unless attendanceSingular.isValid
          throw InvalidAttendanceException
        end
      end
    end
  end
end
