require_relative "./client"
module TeamsIncomingClients
  class TargetDateClient < Client
    # 指定した日付であればメッセージを送信する
    # @return [PostResult]
    # @param [String] text 送信するメッセージ
    # @param [Array, Integer] target_days 送信したい日付。配列で複数条件を渡すことも可能
    # @example client.post("hello world", 25)
    def post(text, target_days)
      if today_match_day?(target_days)
        post_message(text)
      else
        PostResult.new(false, :not_post, "Today is not #{target_days} day")
      end
    end

    private

    # 指定した日付がどうかを判定する
    def today_match_day?(target_days)
      if target_days.is_a?(Array)
        target_days.one? {|target_day| today.today_match_day?(target_day) }
      else
        today.today_match_day?(target_days)
      end
    end
  end
end
