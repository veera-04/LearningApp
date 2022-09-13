class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.references :chapter, null: false, foreign_key: true
      t.string :name
      t.integer :question_count
      t.integer :attempts
      t.integer :high_score
      t.integer :time
      t.timestamps
    end
  end
end
