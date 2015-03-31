class Stats::OverTime::FollowersController < ApplicationController

  def index

    respond_to do |format|

      format.html
      format.json do 

        data = {}
        
        startDate = Date.parse(params[:startDate])
        endDate   = Date.parse(params[:endDate])

        params[:names].split(',').each do |name|

          library = Library.where(:username => name).first

          if library 
            data[library.username] = library.followers_by_date(startDate, endDate)
          end
        
        end

        options = Library.time_series(data)
        options[:title][:text] = "Followers over time"
        options[:subtitle][:text] = "#{startDate} to #{endDate}"
        options[:yAxis][:title][:text] = "# of Followers"

        render json: options

      end

    end

  end
  
end
