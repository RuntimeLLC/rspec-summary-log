module RSpec
  module SummaryLog
    class SummaryLogger < BaseLogger
      RSpec::Core::Formatters.register self, :dump_summary

      def start(*)
        true
      end

      def dump_summary(*args)
        true
      end

      def dump_failures(notification)
        return if notification.failure_notifications.empty?

        lock_output do
          notification.failure_notifications.each_with_index do |failure, index|
            output.puts failure.fully_formatted(index.next, ::RSpec::Core::Formatters::ConsoleCodes)
            output.puts $/ + 'rspec ' + failure.example.location_rerun_argument
          end
        end
        @output.flush
      end

      def dump_pending(*)
        true
      end
    end
  end
end
