module RSpec::Steps
  class StepContext
    attr_reader :before_hooks, :after_hooks, :around_hooks

    def initialize
      @before_hooks = Hash.new { |h, k| h[k] = [] }
      @after_hooks = Hash.new { |h, k| h[k] = [] }
      @around_hooks = Hash.new { |h, k| h[k] = [] }
    end

    def add_before(scope, &block)
      @before_hooks[scope] << block
    end

    def add_after(scope, &block)
      @after_hooks[scope] << block
    end

    def add_around(scope, &block)
      @around_hooks[scope] << block
    end

    def run_before_hooks(scope, example)
      @before_hooks[scope].each { |hook| example.instance_eval(&hook) }
      @before_hooks[scope] = []
    end

    def run_after_hooks(scope, example)
      @after_hooks[scope].each { |hook| example.instance_eval(&hook) }
      @after_hooks[scope] = []
    end

    def run_around_hooks(scope, example, &block)
      # Nest the around hooks
      hooks = @around_hooks[scope]
      return block.call if hooks.empty?

      hooks.reduce(block) do |wrapped_block, hook|
        -> { example.instance_exec(wrapped_block, &hook) }
      end.call

      @around_hooks[scope] = []
    end
  end
end
