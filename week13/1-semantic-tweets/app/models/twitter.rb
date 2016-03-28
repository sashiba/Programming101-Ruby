module Twitter
  attr_accessor :api_key, :api_secret, :oauth_token, :oauth_token_secret
  extend self

  def initializer
    Twitter.api_key = 'Ajez2G0DQOPdI4vMqTFQzhVXY'
    Twitter.api_secret = 'ztUfPFGaxTytKPVKOTSA7plZGHoG9LYvRc5vGdTrjxOSOoolVt'
    Twitter.oauth_token = '2764965513-DolwpqJVWY7cbSiCu8iCnPvRhbcx13GvstWdPwG'
    Twitter.oauth_token_secret = 'niKQrqQgiJgXEGTdrsWMq4N6aqNmT2IeQ9P2WgCOBiIW8'
  end

  def response_body
    response = prepare_token.get('https://api.twitter.com/1.1/statuses/user_timeline.json')
    JSON.parse(response.body)
  end

  def post_tweet(text)
    response = prepare_token.post('https://api.twitter.com/1.1/statuses/update.json',
                                  { status: text })
  end

  private

  def prepare_token
    consumer = OAuth::Consumer.new(api_key,
                                  api_secret,
                                  { :site => 'https://api.twitter.com',
                                    :sheme => :header })
    token_hash = { :oauth_token => oauth_token,
                   :oauth_token_secret => oauth_token_secret }
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end
end
