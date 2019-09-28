class TweetsController < ApplicationController

before_action :move_to_index, except: :index

def index
 @tweets= Tweet.all
 @tweets = Tweet.order("created_at DESC").page(params[:page]).per(5)
end

def show
 @tweet = Tweet.find(params[:id])
end

def new
 @tweet = Tweet.new
end

def create
 @tweet = Tweet.create(tweet_params)
 redirect_to tweets_path
end

def edit
 @tweet = Tweet.find(params[:id])
end

def update
 @tweet = Tweet.find(params[:id])
 if @tweet.update(params.require(:tweet).permit(:name, :text))
  redirect_to tweets_path
 else
  render"edit"
 end
end

def destroy
 @tweet=Tweet.find(params[:id])
 @tweet.destroy
 redirect_to tweets_path
end 

private
def tweet_params
    params.permit(:name,:text)
end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
