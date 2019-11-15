module TeamsIncomingClients
  module Teams
    class Poster
      include Net

      CONTENT_TYPE = { 'Content-Type' => 'application/json' }

      def initialize(webhook_url)
        raise ArgumentError.new("Should be set webhook_url. got: #{webhook_url}") if webhook_url.to_s.empty?

        @webhook_url = webhook_url
        @webhook_uri = URI.parse(webhook_url)
      end

      # @return [Bool]
      def post(message)
        request = build_post_request(message)
        result = client.request(request)

        result.code == "200"
      end

      private
      attr_reader :webhook_url, :webhook_uri

      def client
        @client ||= begin
          client             = HTTP.new(@webhook_uri.host, @webhook_uri.port)
          client.use_ssl     = true
          client.verify_mode = OpenSSL::SSL::VERIFY_NONE
          client
        end
      end

      def build_post_request(message)
        request = HTTP::Post.new(webhook_uri.request_uri, CONTENT_TYPE)
        params = { text: message.to_s }

        request.body = params.to_json

        request
      end
    end
  end
end
