class ArchiveController < ApplicationController

  def index
    @tweets = Tweet.today
    @date = Date.today
  end

  def show
    if params[:id]
      begin
        @date = Date.parse(params[:id])
        @tweets = Tweet.get_by_date(@date)
      rescue
      end
    else
      @tweets = Tweet.today
      @date = Date.today
    end
    render :index
  end
  
end
