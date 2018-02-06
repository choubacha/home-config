#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

# TODO Prompt to copy each of the home directory files into the users home
#      directory so that it recreates it.

COPY_TO_MAPPING = {
  '.vimrc' => "#{Dir.home}/.vimrc",
  '.bash_profile' => "#{Dir.home}/.bash_profile"
}.freeze

def copy(from, to)
  puts "Copying file #{from} to #{to}"
  FileUtils.copy(from, to)
end

root = __dir__
if ARGV[0].to_s.casecmp('extract') == 0
  puts 'Extracting files from system'
  COPY_TO_MAPPING.each do |to, from|
    from = File.expand_path(from)
    next unless File.file?(from)
    to = File.join(root, 'home', to)
    copy(from, to)
  end
else
  puts 'Deploying files to system'
  COPY_TO_MAPPING.each do |from, to|
    to = COPY_TO_MAPPING[from]
    from = File.join(root, 'home', from)
    next unless File.file?(from)
    next unless to
    copy(from, to)
  end
end
