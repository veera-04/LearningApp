class RemoveAttemptsFromExercise < ActiveRecord::Migration[7.0]
  def change
    remove_column :exercises,:attempts,:integer
    remove_column :exercises,:question_count,:integer
    remove_column :attempts,:exercise,:integer
  end
end
