module Wonde
  class SessionAttendanceRecord
    require 'time'
    attr_accessor :student_id, :date, :session, :attendance_code_id, :comment

    # most of these methods are here to be compatible 1:1 with the php module, standard ruby getters and setters should still work too

    def setStudentId(studentId)
      throw InvalidAttendanceException, 'Student id can not be set to null.' if studentId.empty? or studentId.nil?
      @student_id = studentId
    end

    def setAttendanceCodeId(attendanceCodeId)
      if attendanceCodeId.empty? or attendanceCodeId.nil?
        throw InvalidAttendanceException, 'Attendance code id can not be set to null.'
      end
      @attendance_code_id = attendanceCodeId
    end

    def setDate(date)
      throw InvalidAttendanceException, 'Date can not be set to null.' if date.empty? or date.nil?
      begin
        mytime = Time.parse(date).to_i
      rescue StandardError
        throw InvalidAttendanceException, 'Date provided is invalid'
      end
      self.date = Time.at(mytime)
    end

    def setSession(session)
      session = session.upcase

      if %w[AM PM].include? session
        self.session = session
      else
        throw InvalidSessionException, 'The session is invalid'
      end
    end

    def isValid
      !(getDate.empty? || getStudentId.empty? || getSession.empty? || getAttendanceCodeId.empty?)
    end

    def getStudentId
      student_id
    end

    def getAttendanceCodeId
      attendance_code_id
    end

    def getDate
      date.to_s
    end

    def getSession
      session
    end

    def toArray
      required = {
        'date': getDate,
        'session': getSession,
        'student_id': getStudentId,
        'attendance_code_id': getAttendanceCodeId
      }
      required['comment'] = getComment unless getComment.nil? or getComment.empty?
      required
    end

    def getComment
      comment
    end

    def setComment(comment)
      self.comment = comment
    end
  end
end
