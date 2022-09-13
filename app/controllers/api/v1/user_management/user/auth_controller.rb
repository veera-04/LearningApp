class Api::V1::UserManagement::User::AuthController < ApplicationController
    before_action :doorkeeper_authorize!, only: [:logout, :view]
	before_action :validate_user!, only: [:logout, :view]

	def logout
		doorkeeper_token.destroy
	end

	def view
		render json: current_user, serializer: StudentSerializer, status: :ok
	end

    def send_otp
        OtpCreationJob.perform_now(student.id)
        student = StudentSerializer.new(@student).as_json
        render json: {student: student}, status: :created
    end

    def signup

        @student = Student.where(ph_no: student_params['ph_no']).first
        throw_error("Phone number already registered") if @student.present?

        @student = Student.new(student_params.except(:otp,:refresh_token))
        @student.save!

        render json: @student,serializer: StudentSerializer,status: :created

    end

    def login 
        if login_params[:login_type]=='otp'
            @student = Student.authenticate(login_params[:ph_no],login_params[:otp])
            throw_error("Invalid OTP",:unprocessable_entity) if @student.blank?
            
            access_token = Doorkeeper::AccessToken.create(
                resource_owner_id: @student.id,
                refresh_token: generate_refresh_token,
                expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
                scopes: 'student'
            )

            token = {
                access_token: access_token.token,
                token_type: 'bearer',
                expires_in: access_token.expires_in,
                refresh_token: access_token.refresh_token,
                created_at: access_token.created_at
            }

            student = StudentSerializer.new(@student).as_json
            render json: {student: student,token: token},status: :created

        elsif login_params[:login_type]=='refresh_token'

            access_token = Doorkeeper::AccessToken.find_by(refresh_token: student_params[:refresh_token])
            @student = Student.find_by(id: access_token.resource_owner_id )

            if @student.blank?
                throw_error("Token not valid")
            end
            access_token.destroy    
            new_token = Doorkeeper::AccessToken.create(
                resource_owner_id: @student.id,
                refresh_token: student_params[:refresh_token],
                expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
                scopes: 'student'
            )

            token = {
                access_token: new_token.token,
                token_type: 'bearer',
                expires_in: new_token.expires_in,
                refresh_token: new_token.refresh_token,
                created_at: new_token.created_at
            }

            student = StudentSerializer.new(@student).as_json
            render json: {student: student, token: token}, status: :created

        end
    end

    private

    def student_params
        params.require(:student).permit(:name,:ph_no,:email,:dob,:otp,:refresh_token)
    end

    def login_params
        params.require(:student).permit(:ph_no,:otp,:login_type)
    end

end