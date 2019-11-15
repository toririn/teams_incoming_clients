require_relative "./client"
module TeamsIncomingClients
  class WeekdayClient < Client
    # 日本の平日であればメッセージを送信する
    # @return [PostResult]
    # @param [String] text 送信するメッセージ
    # @example client.post("hello world")
    def post(text)
      if today.holiday_date?
        PostResult.new(false, :not_post, "Today is not weekday")
      else
        post_message(text)
      end
    end
  end
end
