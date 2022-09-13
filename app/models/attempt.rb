class Attempt < ApplicationRecord
    belongs_to :student
    belongs_to :exercise
    has_many :attempt_responses
end
