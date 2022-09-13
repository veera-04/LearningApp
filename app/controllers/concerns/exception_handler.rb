# app/controllers/concerns/exception_handler.rb
module ExceptionHandler
    # provides the more graceful `included` method
    extend ActiveSupport::Concern
  
    def throw_error(message, status = :unprocessable_entity)
      raise CustomException::CustomError.new(status, message)
    end
  
    included do
  
      rescue_from ActiveRecord::RecordNotFound do |e|
        render :json => { error: e.message }, :status => :unprocessable_entity
      end
  
      rescue_from ActiveRecord::RecordNotUnique do |e|
        render :json => { error: e.message }, :status => :unprocessable_entity
      end
  
      rescue_from CustomException::CustomError do |e|
        render :json => { error: e.message }, :status => e.status
      end
  
      rescue_from ActionController::ParameterMissing do |e|
        render :json => { error: e.message }, :status => :unprocessable_entity
      end
  
      rescue_from ActiveRecord::DeleteRestrictionError do |e|
        render :json => { error: e.message }, :status => :unprocessable_entity
      end
      
    end
end
  