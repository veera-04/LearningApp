class Exercise < ApplicationRecord
    belongs_to :chapter
    has_many :questions
    has_many :attempts
end
