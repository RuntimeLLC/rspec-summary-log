module RSpec
  module SummaryLog
    class FailedLogger < BaseLogger
      RSpec::Core::Formatters.register self, :dump_summary

      def start(*)
        true
      end

      def dump_failures(*)
        true
      end

      def dump_summary(*args)
        lock_output do
          notification = args.first

          notification.failed_examples.each do |ex|
            output.puts ex.location_rerun_argument
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
