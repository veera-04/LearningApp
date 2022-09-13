class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.references :board_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end
