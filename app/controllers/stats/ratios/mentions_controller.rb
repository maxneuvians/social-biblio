class Stats::Ratios::MentionsController < ApplicationController

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
            data[library.username] = library.ratio_of_tweets_with_mentions(startDate, endDate)
          end
        
        end

        options = Library.stacked_column_chart(data, 'mentions')
        options[:title][:text] = "Ratio of library tweets containing mentions vs. containing no mentions"
        options[:subtitle][:text] = "#{startDate} to #{endDate}"
        options[:yAxis][:title][:text] = "Ratio"

        render json: options

      end

    end

  end

end
