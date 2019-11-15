require_relative "./client"
module TeamsIncomingClients
  class DayOfWeekClient < Client
    # 指定した曜日であればメッセージを送信する
    # @return [PostResult]
    # @param [String] text 送信するメッセージ
    # @param [Array, String, Symbol] week_of_days 送信したいときの曜日の英語文字列。配列で複数条件を渡すことも可能
    # @example client.post("hello world", :monday)
    def post(text, week_of_days)
      if post_week_of_day?(week_of_days)
        post_message(text)
      else
        PostResult.new(false, :not_post, "Today is not #{week_of_days}")
      end
    end

    private

    def post_week_of_day?(week_of_days)
      if week_of_days.is_a?(Array)
        week_of_days.one? {|week_of_day| today.week_of_day?(week_of_day) }
      else
        today.week_of_day?(week_of_days)
      end
    end
  end
end
