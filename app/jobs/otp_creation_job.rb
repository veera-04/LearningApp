class OtpCreationJob < ApplicationJob

  def perform(student_id)

    @student = Student.find(student_id)
    @student.otp = '1234'
    @student.save!

    # OtpSender.call(@student.otp, @student.ph_no)

  end
end
