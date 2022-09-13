class BoardClass < ApplicationRecord
    belongs_to :board
    has_many :students
    has_many :subjects
end
