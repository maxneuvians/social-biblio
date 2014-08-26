module ApplicationHelper
  include Twitter::Autolink
  
  def create_breadcrumbs(controller)
    crumbs = []
    crumbs.push('Social-biblio.ca')
    controller.split('/').each do |segment|
      crumbs.push( segment.gsub('_',' ').titleize )
    end
    crumbs
  end

end
