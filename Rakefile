lib_path = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'adbird'

namespace :adbird do
  task :console do
    require 'pry-byebug'
    binding.pry
  end

  desc 'Start server'
  task :start do
    AdBird::Server.new.start
  end

  desc 'Stop server'
  task :stop do
    AdBird::Server.new.stop
  end

  desc 'Update lists'
  task update: [ :update_lists, :reload_app ] do
  end

  task :update_lists do
    puts 'update_lists'
  end

  task :reload_app do
    puts 'reload_app'
    AdBird::Server.new.reload
  end
end
