module SimplesIdeias
  class Recurrence
    module Event
      class Weekly < Base
        protected
        def validate
          @options[:on] = Array.wrap(@options[:on]).inject([]) do |days, value|
            days << valid_weekday_or_weekday_name?(value)
          end

          @options[:on].sort!
        end

        def next_in_recurrence
          return @date if !initialized? && @options[:on].include?(@date.wday)

          if next_day = @options[:on].find { |day| day > @date.wday }
            to_add = next_day - @date.wday
          else
            to_add = (7 - @date.wday)                # Move to next week
            to_add += (@options[:interval] - 1) * 7  # Add extra intervals
            to_add += @options[:on].first            # Go to first required day
          end

          @date.to_date + to_add
        end
      end
    end
  end
end
