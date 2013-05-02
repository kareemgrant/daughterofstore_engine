require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  task :setup => :environment do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    ENV['QUEUE'] ||= '*'


    Resque.after_fork do |job|
      ActiveRecord::Base.establish_connection
    end

    # Resque.schedule = {}
  end
end