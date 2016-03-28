class Tweet
  attr_accessor :text

  def initialize(text = '')
    @text = text
  end

  def check_length
    @text.length < 140
  end
end
