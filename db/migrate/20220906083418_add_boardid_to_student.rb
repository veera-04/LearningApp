class AddBoardidToStudent < ActiveRecord::Migration[7.0]
  def change
    add_reference :students,:board
  end
end
