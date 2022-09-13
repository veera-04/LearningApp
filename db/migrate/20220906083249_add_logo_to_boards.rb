class AddLogoToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards,:logo,:string
  end
end
