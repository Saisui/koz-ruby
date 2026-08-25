module Koz
  class Event
    attr_accessor :target, :data, :type, :stopped, :box, :path
    def initialize
      @target = nil
      @data = {}
      @type = nil
      @box = Poti
      @path = []
    end

    def dup
      ev = self.class.new
      ev.target = @target
      ev.data = @data.dup
      ev.type = @type.dup
      ev
    end

    def >> photon
      photon.call self
    end

    def to_box
      @box.new(self)
    end
  end
end