module Wonde
  class LessonAttendanceRecord
    attr_accessor :student_id, :lesson_id, :attendance_code_id

    # most of these methods are here to be compatible 1:1 with the php module, standard ruby getters and setters should still work too

    def setStudentId(studentId)
      throw InvalidLessonAttendanceException, 'Student id can not be set to null.' if studentId.empty? or studentId.nil?
      @student_id = studentId
    end

    def setLessonId(lessonId)
      throw InvalidLessonAttendanceException, 'Lesson id can not be set to null.' if lessonId.empty? or lessonId.nil?
      @lesson_id = lessonId
    end

    def setAttendanceCodeId(attendanceCodeId)
      if attendanceCodeId.empty? or attendanceCodeId.nil?
        throw InvalidLessonAttendanceException, 'Attendance code id can not be set to null.'
      end
      @attendance_code_id = attendanceCodeId
    end

    def isValid
      !(getStudentId.empty? || getLessonId.empty? || getAttendanceCodeId.empty?)
    end

    def getStudentId
      student_id
    end

    def getLessonId
      lesson_id
    end

    def getAttendanceCodeId
      attendance_code_id
    end

    def toArray
      {
        'lesson_id': getLessonId,
        'student_id': getStudentId,
        'attendance_code_id': getAttendanceCodeId
      }
    end
  end
end
