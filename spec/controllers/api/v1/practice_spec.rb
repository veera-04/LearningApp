require 'rails_helper'

describe 'Api::V1::Practice', type: :request do

    let!(:student){FactoryBot.create(:student)}
    let!(:valid_header){auth_header(student)}

    let!(:board){FactoryBot.create(:board,name:"cbse",logo:"cbse_logo")}
    let!(:board_class){FactoryBot.create(:board_class,name:"5",board_id: board.id)}

    let!(:mat){FactoryBot.create(:subject,name:"Maths",board_class_id: board_class.id)}
    let!(:mat_ch1){FactoryBot.create(:chapter,name:"Trignometry",subject_id: mat.id)}

    let!(:mat_ch1_ex1){
        FactoryBot.create(
            :exercise,
            chapter_id: mat_ch1.id,
            name: "Trignometry and its Functions",
            high_score: 70,
            time: 30
        )
    }

    let!(:mat_ch1_ex1_q1){FactoryBot.create(
        :question,
        exercise_id: mat_ch1_ex1.id, 
        question:" 2 + 3 = ? ",
        options: "a.5 b.4 c.7 d.6",
        answer: "a.5")
    }

    let!(:current_attempt){
        FactoryBot.create(:attempt,exercise_id: mat_ch1_ex1.id,student_id: student.id)
    }

    describe 'Exercise' do
        it 'gets exercise of a Chapter' do
            get "/api/v1/content_management/practice/exercises/#{mat_ch1.id}", headers: valid_header[:auth]
            expect(body).not_to be_empty
            expect(body).to eq(
                {"exercises"=>[
                    {
                        "id"=> 1,
                        "name"=>"Trignometry and its Functions",
                        "high_score"=> 70,
                        "question_count"=>1,
                        "time"=> 30
                    }
                ]}
            )
        end
    end

    describe 'Questions' do
        it 'gets exercise questions' do
            get "/api/v1/content_management/practice/questions/#{mat_ch1_ex1.id}", headers: valid_header[:auth]
            expect(body).not_to be_empty
            expect(body).to eq(
                {"questions"=>[
                    {"id"=>1, "question"=>" 2 + 3 = ? ", "options"=>"a.5 b.4 c.7 d.6"},
                ]}
            )
        end
    end
    
    describe 'Attempts' do
        let!(:attempt_param){
            {
                attempt:{
                    exercise_id: mat_ch1_ex1.id,
                }
            }
        }
        it 'adds attempt to currentexercise' do
            post '/api/v1/content_management/practice/start',params: attempt_param,as: :json,headers: valid_header[:auth]
            expect(body).not_to be_empty
        end
    end

    describe 'Attempt Response' do
        let!(:valid_params){
            {attempt_response: {
                attempt_id: current_attempt.id,
                question_id: mat_ch1_ex1_q1.id,
                marked_for_review: false
            }}
        }
        it 'gets response of a question' do
            expect{
                post '/api/v1/content_management/practice/submit',params: valid_params,as: :json,headers: valid_header[:auth]
            }.to change {AttemptResponse.count}.from(0).to(1)
            puts body
        end
    end

    # describe 'Finish Exercise' do

    #     let!(:mat_ch1_ex1_q2){FactoryBot.create(
    #         :question,
    #         exercise_id: mat_ch1_ex1.id, 
    #         question:" 2 + 3 = ? ",
    #         options: "a.5 b.4 c.7 d.6",
    #         answer: "a.5")
    #     }

    #     let!(:current_attempt_response){
    #         FactoryBot.create(
    #             :attempt_response,
    #             attempt_id: current_attempt.id,
    #             question_id: mat_ch1_ex1_q1.id,
    #             option_selected: "a.5",
    #             marked_for_review: false,
    #             response_answer: "correct"
    #         )
    #     }

    #     let!(:sattempt){
    #         FactoryBot.create(
    #             :attempt_response,
    #             attempt_id: current_attempt.id,
    #             question_id: 2,
    #             option_selected: "a.5",
    #             marked_for_review: false,
    #             response_answer: "wrong"
    #         )
    #     }
    #     it 'fetch the final result' do
    #         get "/api/v1/content_management/practice/finish/#{current_attempt.id}",headers: valid_header[:auth]
    #     end
    # end

end