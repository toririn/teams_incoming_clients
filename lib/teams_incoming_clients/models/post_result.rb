module TeamsIncomingClients
  class PostResult
    attr_reader :reason, :message

    def initialize(result, reason, message)
      @result = result
      @reason = reason
      @message = message.to_s
    end

    def ok?
      !!result
    end

    def fail?
      !result
    end

    private

    attr_reader :result
  end
end
