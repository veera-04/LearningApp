class AttemptResponse < ApplicationRecord
    belongs_to :attempt
    belongs_to :question
    enum response_answer:{
        correct: 1,
        wrong: 0
    }

end
