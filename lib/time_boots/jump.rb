# encoding: utf-8
module TimeBoots
  class Jump
    def initialize(step, amount)
      @step, @amount = step, amount
      @boot = Boot.get(step)
    end

    attr_reader :step, :amount

    def before(tm = Time.now)
      @boot.decrease(tm, amount)
    end

    def after(tm = Time.now)
      @boot.advance(tm, amount)
    end

    alias_method :ago, :before 
    alias_method :from, :after

    def ==(other)
      step == other.step && amount == other.amount
    end

    def inspect
      '#<%s(%s): %+i>' % [self.class, step, amount]
    end
  end
end
