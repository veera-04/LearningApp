class CreateBoardClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :board_classes do |t|
      t.string :name
      t.references :board, null: false

      t.timestamps
    end
  end
end
