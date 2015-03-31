module ChartHelper
  extend ActiveSupport::Concern

  module ClassMethods

    def column_chart(data)

      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.chart(renderTo: 'graph', type: 'column')
        f.xAxis(categories: data.keys)
        f.yAxis(title:{text: "# of Tweets"})
        f.legend(layout: 'horizontal')
        f.series(name: "Total", data: data.values)
      end 

      options = chart.options
      options[:series] = chart.series_data

      options

    end

    def stacked_column_chart(data, element)

      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.chart(renderTo: 'graph', type: 'column')
        f.xAxis(categories: data.keys)
        f.yAxis(title:{text: "Ratio of Tweets"})
        f.legend(layout: 'horizontal')
        f.plotOptions(column: {stacking: 'percent'} )
        f.series(name: "Tweets containing #{element}", data: data.map{ |result| result.last.first})
        f.series(name: "Tweets containing no #{element}", data: data.map{ |result| result.last.last})
      end 

      options = chart.options
      options[:series] = chart.series_data

      options

    end

    def time_series(data)

      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.chart(zoomType: 'x', type: 'spline', renderTo: 'graph')
        f.xAxis(type:'datetime', minRange: 14 * 24)
        f.yAxis(title:{text:"Tweets"})
        f.plotOptions(spline:{marker:{enabled: true}})
        f.legend(layout: 'horizontal')
        data.each do |name, points|
          f.series(name: name, data: points.map{ |point| [point[0].to_time.to_i * 1000, point[1]] } )
        end
      end 

      options = chart.options
      options[:series] = chart.series_data

      options

    end
    
    def tweets_in_a_day_chart
      
      data = self.get_library_tweets_for_today_by_hour

      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.legend(enabled: false)
        f.xAxis(categories: data.keys.map{|h| "#{h.to_i}:00h"})
        f.yAxis(title: "# of tweets", gridLineWidth: 0, min: 0)
        f.series(name: "Tweets", data: data.values, type: 'spline')
      end

      chart

    end

  end

end