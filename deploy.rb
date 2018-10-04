#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

# TODO Prompt to copy each of the home directory files into the users home
#      directory so that it recreates it.

ROOT = __dir__

BLACKLIST = %w(. ..).freeze

FILES = Dir.entries(File.join(ROOT, 'home'))
  .map { |f| File.basename(f) }
  .reject { |f| BLACKLIST.include?(f) }

def copy(from, to)
  puts "Copying file #{from} to #{to}"
  FileUtils.copy(from, to)
end

def host(file)
  File.join(Dir.home, file)
end

def repo(file)
  File.join(ROOT, 'home', file)
end

cmd = ARGV[0].to_s
if cmd.casecmp('extract') == 0
  puts 'Extracting files from system'
  FILES.each do |file|
    from = host(file)
    next unless File.file?(from)
    to = repo(file)
    copy(from, to)
  end
elsif cmd.casecmp('deploy') == 0
  puts 'Deploying files to system'
  FILES.each do |file|
    to = host(file)
    from = repo(file)
    next unless File.file?(from)
    next unless to
    copy(from, to)
  end
else
  puts "Please specify whether you you'd like to 'extract' or 'deploy'"
end
