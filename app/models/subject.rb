class Subject < ApplicationRecord
  belongs_to :board_class
  has_many :chapters
end
