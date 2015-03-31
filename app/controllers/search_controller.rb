class SearchController < ApplicationController

  def index
    params[:page] ||= 1
    @tweets = Tweet.search_by_content(params[:query]).page(params[:page].to_i)
  end

end
