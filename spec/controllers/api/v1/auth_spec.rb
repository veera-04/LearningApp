require 'rails_helper'

describe "Api::V1::Auth" ,type: :request do

    describe "Signup" do
        let(:valid_params){
            {
                student:{
                    name: "Veera",
                    ph_no: "9876543210",
                    email: "asd@fgh.com",
                    dob: "08/08/08"
                }
            }
        }
        it "allows student to create an account" do

            post '/api/v1/user_management/user/auth/signup', params: valid_params,as: :json
            expect(body).not_to be_empty
            expect(body).to eq(
                {"student"=>{
                    "id"=> 1,
                    "name"=> "Veera",
                    "ph_no"=> "9876543210",
                    "email"=> "asd@fgh.com",
                    "dob"=> "08/08/08"
                }}
            )
        end
    end

    describe 'Login' do
        
        let!(:student){FactoryBot.create(:student)}

        context "Valid ph_no and otp" do
            let(:valid_params){
                {
                    student:{
                        ph_no: "9876543210",
                        otp: 4321,
                        login_type: "otp" 
                    }
                }
            }
            it "generates token" do
                post '/api/v1/user_management/user/auth/login',params: valid_params,as: :json
                # puts body

                expect(body).not_to be_empty
                expect(body["student"]).not_to be_empty
                expect(body["token"]).not_to be_empty

            end
        end

        context "Using refresh token" do
            let!(:valid_header){auth_header(student)}
            let(:valid_params){
                {
                    student:{
                        refresh_token: valid_header[:other]['refresh-token'],
                        login_type: "refresh_token"
                    }
                }
            }
            it 'verifies user' do
                post '/api/v1/user_management/user/auth/login',params: valid_params,as: :json
                # puts body
                
                expect(body).not_to be_empty
                expect(body["student"]).not_to be_empty
                expect(body["token"]).not_to be_empty
            end
        end

    end
end