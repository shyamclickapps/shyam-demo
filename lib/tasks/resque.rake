require 'resque/tasks'

task 'resque:setup' => :environment

#Resque.enqueue(SleepingJob)
