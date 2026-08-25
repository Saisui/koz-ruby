require 'yaml'

module Koz
  class Config
    def self.connect_file path
      new(path)
    end

    def keys
      @config.keys
    end

    def key? key
      @config.key? key
    end

    def initialize path
      @path = path
      @config = YAML.load_file(path)
      @handler = -> (keys, new_value, old_value) {  }
    end

    def handle &blk
      @handler = blk
    end

    def reload
      @config = YAML.load_file(@path)
    end

    def to_yaml
      @config.to_yaml
    end

    def save_config
      File.write(@path, @config.to_yaml)
    end

    def get key, *rest
      # keys = key.split('/')
      @config.dig(key, *rest)
    end

    def set *keys, new_value, yaml: false
      return false if keys.empty?
      # keys = keys.map{_1.split("/")}.flatten
      if yaml
        new_value = YAML.load(value)
      end
    
      key = keys.last
      if keys.size > 1
        container = @config.dig(*keys[..-2])
      else
        container = @config
      end
      old_value = container[key]
      container[key] = JSON.parse(new_value.to_json)
      @handler.call(keys, new_value, old_value)
      save_config
    end

    def yaml_set(*)
      set(*, yaml: true)
    end

    def safe_get(*)
      YAML.load get(*).to_yaml
    end

    # insert an element to a array [key]
    def insert element, at:
      case at
      when String
        if @config.key? at
          @config[at]
        else
          @config.dig(*at.split(/[\/.]/))
        end
      when Array
        @config.dig(*at)
      end.push element
      save_config
    end

    # delete an element at array [key]
    def delete element, at:
      case at
      when String
        if @config.key? at
          @config[at]
        else
          @config.dig(*at.split(/[\/.]/))
        end
      when Array
        @config.dig(*at)
      end.delete element
      save_config
    end

    alias [] get
    alias []= set

  end

  class Event
    attr_accessor :config
  end
  
  class Box
    def config
      @event.config
    end
  end

end