require 'rails_helper'

describe 'Api::V1::Learn',type: :request do

    let!(:student){FactoryBot.create(:student)}
    let!(:valid_header){auth_header(student)}

    let!(:board){FactoryBot.create(:board,name:"cbse",logo:"cbse_logo")}
    let!(:board_class){FactoryBot.create(:board_class,name:"5",board_id: board.id)}

    let!(:mat){FactoryBot.create(:subject,name:"Maths",board_class_id: board_class.id)}
    let!(:phy){FactoryBot.create(:subject,name:"Physics",board_class_id: board_class.id)}

    let!(:mat_ch1){FactoryBot.create(:chapter,name:"Trignometry",subject_id: mat.id)}
    let!(:mat_ch2){FactoryBot.create(:chapter,name:"Trignometry Applications",subject_id: mat.id)}
    let!(:phy_ch1){FactoryBot.create(:chapter,name:"Gravity",subject_id: phy.id)}

    let!(:mat_ch1_content){FactoryBot.create(:content,chapter_id:mat_ch1.id,content_type:1,content:"video_url")}
    let!(:phy_ch1_content){FactoryBot.create(:content,chapter_id:phy_ch1.id,content_type:2,content:"pdf_url")}

    describe 'Subject' do
        it 'gets subject' do
            get "/api/v1/content_management/learn/subjects/#{board_class.id}",headers: valid_header[:auth]
            expect(body).not_to be_empty
            expect(body).to eq(
                {"subjects"=>[{
                    "id"=>1,
                    "name"=>"Maths"
                },
                {
                    "id"=>2,
                    "name"=>"Physics"
                }]}
            )
        end
    end

    describe 'Chapter' do
        it 'gets chapters' do
            get "/api/v1/content_management/learn/chapters/#{mat.id}", headers: valid_header[:auth]
            expect(body).not_to be_empty
            expect(body).to eq(
                {"chapters"=>[
                    {
                        "id"=>1,
                        "name"=>"Trignometry"
                    },
                    {
                        "id"=>2,
                        "name"=>"Trignometry Applications"
                    }
                ]}
            )
        end
    end

    describe 'Content' do
        it 'gets content' do
            get "/api/v1/content_management/learn/contents/#{phy_ch1.id}",headers: valid_header[:auth]
            expect(body).not_to be_empty
            expect(body).to eq(
                {"contents"=>[
                    {
                        "id"=>2,
                        "content_type"=>"pdf",
                        "content"=>"pdf_url"
                    }
                ]}
            )
        end
    end

end
