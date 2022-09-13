class ApplicationController < ActionController::API
    include CustomException
	include ExceptionHandler
	include ActiveUser
	include Pagination
end
