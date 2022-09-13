class Student < ApplicationRecord
    
    belongs_to :board, optional: true
    belongs_to :board_class, optional: true
    has_many :attempts

    def self.authenticate(ph_no,otp)
        student = Student.find_by(ph_no: ph_no)
        # puts("#{student.otp}  #{otp}  #{student.otp == otp}")
        (student.otp.to_i == otp.to_i) ? student : nil
    end
end
