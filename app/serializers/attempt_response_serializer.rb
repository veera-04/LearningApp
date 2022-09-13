class AttemptResponseSerializer < ActiveModel::Serializer
  attributes :id,:marked_for_review,:option_selected,:response_answer,:attempt_id
end
