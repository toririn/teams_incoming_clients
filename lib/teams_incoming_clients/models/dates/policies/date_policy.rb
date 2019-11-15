module TeamsIncomingClients
  module Dates
    module Policies
      class DatePolicy
        def initialize(target_date)
          @target_date = target_date
        end

        def holiday_date?
          common_flag        = (target_date.saturday? || target_date.sunday?)
          japan_holiday_flag = HolidayJapan.check(target_date)
          common_flag || japan_holiday_flag
        end

        def week_of_day?(week_of_day)
          week_of_day_string = week_of_day.to_s.downcase
          @target_date.send("#{week_of_day_string}?")
        end

        def today_match_day?(day_num)
          target_date.day == day_num.to_i
        end

        private
        attr_reader :target_date
      end
    end
  end
end
