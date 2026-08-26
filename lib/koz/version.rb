# frozen_string_literal: true
require 'yaml'

module Koz
  VERSION = YAML.load_file(__dir__+'/../../gem.yaml')['version']
end
