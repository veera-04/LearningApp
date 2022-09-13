class Question < ApplicationRecord
    belongs_to :exercise
    has_many :attempt_responses
end
