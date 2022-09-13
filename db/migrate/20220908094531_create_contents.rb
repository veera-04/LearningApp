class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.references :chapter, null: false, foreign_key: true
      t.integer :content_type, default: 0
      t.timestamps
    end
  end
end
