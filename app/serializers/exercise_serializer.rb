class ExerciseSerializer < ActiveModel::Serializer
  attributes :id,:name,:time,:high_score,:question_count
  
  def question_count
    Question.where(exercise_id: @object.id).count
  end
end
