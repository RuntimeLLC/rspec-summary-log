#stolen from ParallelTests
module RSpec
  module SummaryLog
    begin
      require 'rspec/core/formatters/base_text_formatter'
      BaseLogger = Class.new(RSpec::Core::Formatters::BaseTextFormatter)
    rescue LoadError
      require 'spec/runner/formatter/base_text_formatter'
      BaseLogger = Class.new(Spec::Runner::Formatter::BaseTextFormatter)
    end

    class BaseLogger
      def initialize(*args)
        super

        @output ||= args[1] || args[0] # rspec 1 has output as second argument

        if String === @output # a path ?
          FileUtils.mkdir_p(File.dirname(@output))
          File.open(@output, 'w'){} # overwrite previous results
          @output = File.open(@output, 'a')
        elsif File === @output # close and restart in append mode
          @output.close
          @output = File.open(@output.path, 'a')
        end
      end

      #stolen from Rspec
      def close(*args)
        @output.close  if (IO === @output) & (@output != $stdout)
      end

      protected

      # do not let multiple processes get in each others way
      def lock_output
        if File === @output
          begin
            @output.flock File::LOCK_EX
            yield
          ensure
            @output.flock File::LOCK_UN
          end
        else
          yield
        end
      end

      # From Rspec v3.3 rerun_argument becomes to be deprecated
      def example_rerun_argument(example)
        if example.respond_to?(:location_rerun_argument)
          example.location_rerun_argument
        else
          example.rerun_argument
        end
      end
    end
  end
end
