class WordScheduler

  attr_reader :job_id

  def initialize(speed, words, color_option)
    @speed = speed
    @words = words
    @color_option = color_option
  end

  def interval
    (60.0/@speed).round(1).to_s + 's'
  end

  def start_sending
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
