#
# Copyright (c) 2013 by Lifted Studios. All Rights Reserved.
#

require 'English'
require 'yard'

# Retrieves all global values of the given `key`.
#
# @param [String] key Configuration key for which to retrieve values.
# @return [Array<String>] List of values for the given `key`.
def git_config_get(key)
  `git config --global --get #{key}`.split($RS)
end

# Gets the user's home directory.
#
# @return [String] Absolute path to the user's home directory.
def home
  File.expand_path('~')
end

# @return [Symbol] OS identifier.
def os_name
  case `uname -s`
  when /Darwin/ then :os_x
  when /Linux/ then :linux
  else :unknown
  end
end

task :default => :yard

desc 'Install the standard environment'
task :install => [:package_manager, :fish, :tools]

desc 'Install the standard tools'
task :tools => [:git, :pry]

task :git => [:git_install] do
  root = Dir.pwd

  include_path = File.join(root, 'config', 'git')
  if !(git_config_get('include.path').any? { |path| path =~ /^#{include_path}/ })
    sh "git config --global --add include.path '#{include_path}'"
  end

  if os_name == :os_x
    excludes_path = File.join(root, 'config', 'gitignore_osx')
  end

  if excludes_path && !(git_config_get('core.excludesfile').any? { |path| path =~ /^#{excludes_path}/ })
    sh "git config --global --add core.excludesfile '#{excludes_path}'"
  end
end

task :git_install do
  unless File.exists? '/usr/local/bin/git'
    case os_name
    when :os_x
      sh 'brew install git'
    when :linux
      sh 'apt-get install --assume-yes git'
    end
  end
end

task :pry => :pry_config

task :pry_config do
  mkdir_p File.join(home, '.pry', 'themes')
  cp './config/blackboard.prytheme.rb', File.join(home, '.pry', 'themes')
  cp './config/pryrc', File.join(home, '.pryrc')
end

task :package_manager do
  if os_name == :os_x && !(File.exists? '/usr/local/bin/brew')
    sh 'ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"'
  end
end

desc 'Print out the detected OS'
task :os do
  puts os_name
end

task :fish_install do
  unless File.exists? '/usr/local/bin/fish'
    case os_name
    when :os_x
      sh 'brew install fish'
    when :linux
      sh 'apt-get install --assume-yes fish'
    end
  end
end

task :fish do
  fish_config = File.join(Dir.pwd, 'fish', 'config.fish')

  File.open(File.join(home, '.config', 'fish', 'config.fish'), 'w') do |file|
    file.puts "[ -r #{fish_config} ]; and . #{fish_config}"
  end
end

task :zsh do
  if ENV['SHELL'] != '/bin/zsh'
    sh "chsh -s /bin/zsh"
  end

  zshrc = File.join(Dir.pwd, 'Profile', 'zshrc')

  File.open(File.join(home, '.zshrc'), 'w') do |file|
    file.puts "[[ -e #{zshrc} ]] && source #{zshrc}"
  end
end

YARD::Rake::YardocTask.new
