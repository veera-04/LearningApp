class Api::V1::ContentManagement::PracticeController < ApplicationController

    before_action :doorkeeper_authorize!
	before_action :validate_user!

    def exercises
        @exercise = exercise_param
        if @exercise.exists?
            render json:@exercise,each_serializer: ExerciseSerializer, status: :ok
        end
    end

    def start
        @attempt = Attempt.new(exercise_id: start_attempt['exercise_id'],student_id: current_user.id)
        if @attempt.save!
            render json: @attempt,status: :ok
        else 
            render json: @attempt.errors,status: :unprocessable_entity
        end
    end

    def questions
        render json: question_param,each_serializer: QuestionSerializer, status: :ok
    end

    def submit
        answer = Question.find_by(id: submit_param['question_id']).answer
        if(submit_param['option_selected'] == answer)
            response_answer=1
        else
            response_answer=0
        end
        @attempt_response = AttemptResponse.new(
            attempt_id: submit_param['attempt_id'],
            question_id: submit_param['question_id'],
            option_selected: submit_param['option_selected'],
            marked_for_review: submit_param['marked_for_review'],
            response_answer: response_answer
        )
        if @attempt_response.save!
            render json: @attempt_response
        else
            render json: @attempt_response.errors, status: :unprocessable_entity
        end
    end

    # def finish
    #     score = AttemptResponse.where(attempt_id: params[:id], response_answer: "correct").count
    #     exercise_id = Attempt.find_by(id: params[:id]).exercise_id
    #     total_questions = Question.where(exercise_id: exercise_id).count
    #     accuracy = ((score.to_f/total_questions.to_f)*100).to_i
    #     submit_attempt = Attempt.where(a)
    # end

    private

    def exercise_param
        Exercise.where(chapter_id: params[:id])
    end

    def start_attempt
        params.require(:attempt).permit(:exercise_id)
    end

    def question_param
        Question.where(exercise_id: params[:id])
    end

    def submit_param
        params.require(:attempt_response).permit(:attempt_id,:question_id,:option_selected,:marked_for_review)
    end

end