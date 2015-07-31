class WordScheduler

  attr_reader :job_id

  def self.start(speed, words, color_option)
    scheduler = self.new(speed, words, color_option)
    scheduler.start
    return scheduler.job_id
  end

  def self.pause(job_id)
    job = Rufus::Scheduler.singleton.job(job_id)
    job.pause unless job.paused?
  end

  def self.resume(job_id)
    job = Rufus::Scheduler.singleton.job(job_id)
    job.resume if job.paused?
  end

  def initialize(speed, words, color_option)
    @speed = speed
    @words = words
    @color_option = color_option
  end

  def interval
    (60.0/@speed).round(1).to_s + 's'
  end

  def start
    i = 0

    @job_id = Rufus::Scheduler.singleton.every interval, :times => num_of_times do
      send(@words[i])
      i += 1
    end
  end

  private

  def send(word)
    RestClient.post(
      ENV['COLOR_URL'] + '/color',
      {
        :word => word,
        :color => @color_option
      }
    )
  end

  def num_of_times
    @words.length
  end

end
