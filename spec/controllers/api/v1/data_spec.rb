require 'rails_helper'

describe "Api::V1::Data", type: :request do

    let!(:student){FactoryBot.create(:student)}
    let!(:valid_header){auth_header(student)}
    
    let!(:board1){FactoryBot.create(:board,name:"cbse",logo:"cbse_logo")}
    let!(:board2){FactoryBot.create(:board,name:"icse",logo:"icse_logo")}

    let!(:board_class1){FactoryBot.create(:board_class,name:"5",board_id: board1.id)}
    let!(:board_class2){FactoryBot.create(:board_class,name:"6",board_id: board1.id)}

    describe "Board" do

        it 'gets board' do
            get '/api/v1/user_management/user/data/boards',headers: valid_header[:auth]
            expect(body).to eq(
               { "boards"=>[
                {"id"=> 1,"logo"=>"cbse_logo","name"=>"cbse"},
                {"id"=>2,"logo"=>"icse_logo","name"=>"icse"}
                ]}
            )
        end

        let!(:param){
            {
                student: {
                    board_id: board1.id
                }
            }
        }

        it 'stores student board' do
            put '/api/v1/user_management/user/data/board',params: param,as: :json,headers: valid_header[:auth]
            expect(body).to eq(
                {"board"=>{
                    "id"=>1, 
                    "logo"=>"cbse_logo", 
                    "name"=>"cbse"
                }}
            )
            expect(response).to have_http_status(:ok)
        end

    end

    describe "Classes" do

        it 'gets classes of a board' do

            get "/api/v1/user_management/user/data/classes/#{board1.id}",headers: valid_header[:auth]
            expect(body).to eq(
                {"board_classes"=>[
                    {"id"=>1, "name"=>"5"},
                    {"id"=>2, "name"=>"6"}
                ]}
            )

        end

        let!(:valid_param){
            {
                student: {board_class_id: board_class1.id}
            }
        }

        it 'stores student class' do
            put '/api/v1/user_management/user/data/board_class',params: valid_param,as: :json,headers: valid_header[:auth]
            expect(body).not_to be_empty
            expect(body).to eq({"board_class"=>{"id"=>1,"name"=>"5"}})
        end

    end

end