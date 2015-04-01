class SearchController < ApplicationController

  def index
    params[:page] ||= 1
    @tweets = Tweet.search(params[:query]).page(params[:page].to_i).records
  end

end
