class Admin::LibrariesController < ApplicationController

  before_action :authenticated?

  def create
    library = Library.new
    library.build_from_screename(params[:screen_name])

    if library 
      flash[:success] = "@#{library.username} added to tracker"
    else
      flash[:error] = library.errors.full_messages.to_sentence
    end

    redirect_to admin_libraries_path

  end

  def destroy

    library = Library.where(:id => params[:id]).first 

    if library
      library.delete
      flash[:success] = "Library removed from tracker"
    else
      flash[:error] = "Library could not be found"
    end

    redirect_to admin_libraries_path

  end

  def index
  end

  def restart_tracker
    system "ruby lib/tracker.rb restart"
    flash[:success] = "Tracker restarted"
  end

end
