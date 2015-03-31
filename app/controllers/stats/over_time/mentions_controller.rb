class Stats::OverTime::MentionsController < ApplicationController

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
            data[library.username] = library.mentions_by_date(startDate, endDate)
          end
        end

        options = Library.time_series(data)
        options[:title][:text] = "Mentions over time"
        options[:subtitle][:text] = "#{startDate} to #{endDate}"

        render json: options

      end

    end

  end
  
end
