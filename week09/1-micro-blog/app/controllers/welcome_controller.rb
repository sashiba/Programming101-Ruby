class WelcomeController < ApplicationController
  def index
    @photos = Photo.all
    @posts = Post.all
  end
end
