class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.integer :score 
      t.integer :accuracy
      t.timestamps
    end
  end
end
