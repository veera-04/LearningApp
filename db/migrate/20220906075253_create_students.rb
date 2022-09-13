class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :ph_no
      t.string :email
      t.string :dob
      t.integer :otp

      t.timestamps
    end
  end
end
