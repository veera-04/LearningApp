class Board < ApplicationRecord
    has_many :board_classes
    has_many :students
end
