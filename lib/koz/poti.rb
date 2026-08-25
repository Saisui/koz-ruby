module Koz

  class BasePoti

    class << self
      
      def class_initialize
        @_entrance = -> (event) {}
        @_class = 'Poti'
      end

      attr_accessor :_entrance

      def inheritance(&blk)
        klass = Class.new(self)
        if blk
          case blk.arity
          when 0
            klass.class_eval(&blk) 
          when 1
            blk.call(klass)
          end
        end
        klass
      end

      def inherited klass
        klass.class_initialize
      end

      def enter &blk
        @_entrance = blk
      end

      def call event
        _call event
      end

      def _call(event)
        event
      end

      def to_proc
        -> (event) { self.call(event) }
      end

      def inspect
        name ? "#{name} < #{@_class}" : "#{@_class}.inheritance"
      end

    end

    class_initialize

  end

  class Poti < BasePoti

    class << self
      def _call event
        return event if event.stopped
        event = super(event)
        box = new(event)
        catch :outer_of_enter do
          @_entrance.call(box)
        end
        event
      end

      def >> pot
        -> (event) { pot.call self.call event }
      end

      def test(**, &blk)
        ev = Event.new
        ev.data = {**}
        yield(ev) if blk
        call(ev)
      end

    end

    attr_accessor :event#, :nowa_block

    def initialize event
      @event = event
    end

    def data; @event.data; end
    def target; @event.target; end
    def type; @event.type; end
    def type= ano; @event.type= ano; end

    def stop; @event.stopped = true
    end

    def on(type=true, **kws, &blk)
      case type
      when false, nil
        return type
      when true
      when Array
        type.include?(@event.type)
      else
        type === @event.type
      end

      s_kws = kws.transform_keys(&:to_s)
      all_match = s_kws.map { |k, v| v === @event.data[k] }.all?
      if all_match && blk
        # orig_block = @nowa_block
        # @nowa_scope = blk
        catch(:outer) { blk.call }
        # @nowa_block = orig_block
      end
      all_match
    end

    def group name=nil, cond=true, &blk
      if cond
        catch :outer do
          if name
            catch :"group_of_#{name}" do
              blk.call
            end
          else
            blk.call
          end
        end
      end
    end

    def pass; throw :outer_of_enter, self
    end

    # def halt; throw :outer_of_pipe, self
    # end

    def stop; @event.stopped = true
    end

    def out; throw :outer
    end

    class_initialize

  end

end
