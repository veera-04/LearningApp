module ActiveUser

    def validate_user!
        user = Student.find_by(id: doorkeeper_token.resource_owner_id) unless doorkeeper_token.blank?
        throw_error("Unauthorised User",401) if user.blank?
    end

    def current_user
        Student.find_by(id: doorkeeper_token.resource_owner_id) unless doorkeeper_token.blank?
    end

    def generate_refresh_token
        loop do
            token = SecureRandom.hex(32)
            break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
        end
    end
end