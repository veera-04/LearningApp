module RequestHelper
    
    def body
        JSON.parse(response.body)
    end

    def auth_header(student)
        post '/api/v1/user_management/user/auth/login', params: { 
            student: { 
                login_type: "otp", 
                ph_no: student.ph_no, 
                otp: 4321 
            }
        }
        return { 
            auth:
            { 
                'Content-Type' => response.headers['Content-Type'],
                'Authorization' => "Bearer #{JSON.parse(response.body)["token"]["access_token"]}" 
            },
            other: 
            { 
                'refresh-token' => JSON.parse(response.body)["token"]["refresh_token"], 
                'access-token' => JSON.parse(response.body)["token"]["access_token"] 
            }  
        }
    end

end