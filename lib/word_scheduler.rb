class WordScheduler

  attr_reader :job_id

  def self.start(page, speed)
    words = page.words
    scheduler = self.new(words, speed)
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

  def initialize(words, speed)
    @words = words
    @speed = speed
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
      ENV["SEND_URL"],
      {
        :word => word
      }
    )
  end

  def num_of_times
    @words.length
  end

end
