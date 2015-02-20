#!/usr/bin/env ruby
# coding: utf-8

require 'skyline'
require 'methadone'

class App
  include Methadone::Main

  leak_exceptions true

  # Set Version
  version Skyline::VERSION
  description "A log analyzer"

  # This is the main instructions
  main do |url|

  end

  # These are the options
  # on('-c', '--config CONFIG', "Config")

  # Grab to webhook url
  arg :log

  begin

    # No Args?
    if ARGV.empty?
      puts "Please provide a target config file"
      exit!
    end

    go!

 rescue Interrupt
    print "\b\b\n"; # Remove ^C from screen
    puts "Caught interrupt; exiting."
  rescue => e
    puts "An error occurred: #{e.class.name}: #{e.message}"
  end

end