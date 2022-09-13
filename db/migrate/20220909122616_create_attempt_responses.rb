class CreateAttemptResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :attempt_responses do |t|
      t.references :attempt,null: false,foreign_key: true
      t.references :question,null: false,foreign_key: true
      t.string :option_selected
      t.boolean :marked_for_review
      t.integer :response_answer, default: 0
      t.timestamps
    end
  end
end
