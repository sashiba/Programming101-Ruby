class TweetsController < ApplicationController
  before_action :initializer

  def index
    @tweets = Twitter.response_body
    @filtered_positive = TweetStatus.filter_positive(@tweets)
    @filtered_negative = TweetStatus.filter_negative(@tweets)
    @filtered_neutral = TweetStatus.filter_neutral(@filtered_positive, @filtered_negative)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(params[:text])
    if @tweet.check_length
      Twitter.post_tweet(@tweet.text)
      flash[:success] = 'Tweet posted.'
      redirect_to root_url
    else
      flash[:error] = 'Too long tweet.'
      render :new
    end
  end

  private

  def initializer
    Twitter.initializer
  end
end
