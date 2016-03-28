class TweetStatus

  POSITIVE_WORDS = ['able', 'accept', 'allow', 'amazing', 'benefit', 'best',
                    'care', 'decent', 'fantstic', 'friendly', 'good', 'hope',
                    'isnpired', 'joy', 'positive', 'kind', 'optimist', 'optimistic', 'yes']

  NEGATIVE_WORDS = ['angry', 'annoy', 'bad', 'boring', 'cruel', 'cry', 'dead', 'hate',
                    'fear', 'greed', 'grave', 'no', 'never', 'negative', 'not', 'stupid']

  def self.filter_positive(tweets)
    filtered_positive = []
    tweets.each do |tweet|
      if tweet['text'].downcase.split(' ').any? { |word| POSITIVE_WORDS.include?(word) }
        filtered_positive << tweet
      end
    end

    filtered_positive
  end

  def self.filter_negative(tweets)
    filtered_negative = []
    tweets.each do |tweet|
      if tweet['text'].downcase.split(' ').any? { |word| NEGATIVE_WORDS.include?(word) }
        filtered_negative << tweet
      end
    end

    filtered_negative
  end

  def self.filter_neutral(positive_tweets, negative_tweets)
    filtered_neutral = positive_tweets.select { |t| negative_tweets.include?(t) }
  end
end
