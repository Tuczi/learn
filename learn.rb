#!/bin/ruby

require 'yaml'
require 'colorize'

require_relative 'question'
require_relative 'manager'

manager = Manager.new(YAML.load_file('data.yml'))
manager.call
