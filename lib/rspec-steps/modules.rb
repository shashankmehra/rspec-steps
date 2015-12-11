module RSpec::Steps
  class ModuleExtension
    def initialize(mod)
      @mod = mod
    end

    def apply(target)
      mod = @mod
      target.instance_eval { extend mod }
    end
  end

  class ModuleInclusion
    def initialize(mod)
      @mod = mod
    end

    def apply(target)
      mod = @mod
      target.instance_eval { include mod }
    end
  end
end
