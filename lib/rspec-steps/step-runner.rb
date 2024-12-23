module RSpec::Steps
  class StepExampleRunner
    def initialize(context_example, running_example)
      @context_example = context_example
      @running_example = running_example

      @let_hash = {}
      @subject_hash = {}
      @counter = 0
    end

    def should(matcher = nil, message = nil)
      expect(subject).to(matcher, message)
    end

    def should_not(matcher = nil, message = nil)
      expect(subject).not_to(matcher, message)
    end

    def is_expected
      expect(subject)
    end

    def method_missing(method, *args, &block)
      method = @let_hash[method] if @let_hash.key?(method)
      method = @subject_hash[method] if @subject_hash.key?(method)
      @context_example.send(method, *args, &block)
    end

    def respond_to_missing?(method, include_private = false)
      method = @let_hash[method] if @let_hash.key?(method)
      method = @subject_hash[method] if @subject_hash.key?(method)
      @context_example.respond_to?(method, include_private)
    end
  end

  class StepRunner
    def initialize(context_example, running_example)
      @context_example = context_example
      @running_example = running_example

      @example_runner = StepExampleRunner.new(@context_example, @running_example)
    end

    def describe(description, metadata = {}, &block)
      @example_runner.instance_eval { @counter += 1 }
      instance_eval(&block)
    end

    def it(*all_args, &block)
      @example_runner.instance_eval(&block)
    end

    def let(name, &block)
      example_runner = @example_runner
      example_runner.instance_eval do
        @let_hash[name] = "#{name}_#{@counter}"
        @context_example.class.let("#{name}_#{@counter}") do
          example_runner.instance_eval(&block)
        end
      end
    end

    def subject(name = nil, &block)
      name = :subject if name.nil?
      example_runner = @example_runner
      example_runner.instance_eval do
        @subject_hash[name] = "#{name}_#{@counter}"
        @context_example.class.subject("#{name}_#{@counter}") do
          example_runner.instance_eval(&block)
        end
      end
    end

    def method_missing(method, *args, &block)
      @context_example.class.send(method, *args, &block)
    end

    def respond_to_missing?(method, include_private = false)
      @context_example.class.respond_to?(method, include_private)
    end
  end
end
