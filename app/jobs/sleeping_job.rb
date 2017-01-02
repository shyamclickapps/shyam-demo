class SleepingJob
  @queue = 'testqueue'

  def self.perform
    puts 'I like to sleep'
    sleep 2
  end
end
