class Stats::Totals::TweetsController < ApplicationController

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
            data[library.username] = library.total_tweets(startDate, endDate)
          end
        
        end

        options = Library.column_chart(data)
        options[:title][:text] = "Total tweets"
        options[:subtitle][:text] = "#{startDate} to #{endDate}"

        render json: options

      end

    end

  end
  
end
