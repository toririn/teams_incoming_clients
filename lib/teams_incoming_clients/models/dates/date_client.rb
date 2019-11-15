module TeamsIncomingClients
  module Dates
    class DateClient
      include Policies

      attr_reader :target_day

      def initialize(target_date)
        @target_day = target_date
        @policy = DatePolicy.new(target_date)
      end

      def holiday_date?
        policy.holiday_date?
      end

      def week_of_day?(week_of_day)
        policy.week_of_day?(week_of_day)
      end

      def today_match_day?(day_num)
        policy.today_match_day?(day_num)
      end

      private

      attr_reader :policy
    end
  end
end
