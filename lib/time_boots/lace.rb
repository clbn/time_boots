# encoding: utf-8
module TimeBoots
  class Lace
    def initialize(step, from, to, options = {})
      @boot = Boot.get(step)
      @from, @to = from, to
      @options = options.dup

      expand! if options[:expand]
    end

    attr_reader :from, :to

    def expand!
      @from = boot.floor(from)
      @to = boot.ceil(to)
      
      self
    end

    def expand
      dup.tap(&:expand!)
    end

    def pull(beginnings = false)
      seq = []

      iter = from
      while iter < to
        seq << iter

        iter = cond_floor(boot.advance(iter), beginnings)
      end
      
      seq
    end

    def pull_pairs(beginnings = false)
      seq = pull(beginnings)
      seq.zip(seq[1..-1] + [to])
    end

    def pull_ranges(beginnings = false)
      pull_pairs(beginnings).map{|b, e| (b...e)}
    end

    def inspect
      "#<#{self.class}(#{from} - #{to})>"
    end

    private

    def cond_floor(tm, should_floor)
      should_floor ? boot.floor(tm) : tm
    end
    
    attr_reader :boot
  end
end
