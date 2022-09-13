module CustomException
    class CustomError < StandardError
      attr_reader :status, :message
  
      def initialize( _status=nil, _message=nil)
        @status = _status || :unprocessable_entity
  
        if _message.class.to_s == "Array"
            @message = _message.uniq.join(", ") || 'Something went wrong'
        else
            @message = _message || 'Something went wrong'
        end
      end
    end
end
  