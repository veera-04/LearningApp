class AddContentToContent < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :content, :string
  end
end
