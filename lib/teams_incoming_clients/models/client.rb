require_relative "./teams/poster"
require_relative "./post_result"
require_relative "./modules/client_configure"
module TeamsIncomingClients
  class Client
    extend Modules::ClientConfigure
    include Teams
    include Dates

    # @param [String] webhook_url Teamsに送信するためのIncomingWebhoolURL
    def initialize(webhook_url)
      @poster = Poster.new(webhook_url)
    end

    # メッセージを送信する
    # @return [PostResult]
    # @param [String] text 送信するメッセージ
    # @example client.post("hello world")
    def post(text)
      post_message(text)
    end

    private
    attr_reader :poster

    def today
      @today ||= begin
        if Client.today_date && date = Client.today_date.to_date
          setting_date = date
        else
          setting_date = Date.today
        end
        DateClient.new(setting_date)
      end
    end

    def post_message(text)
      if poster.post(text)
        PostResult.new(true, :success, "status code 200")
      else
        PostResult.new(false, :fail, "status code is not 200")
      end
    end
  end
end
