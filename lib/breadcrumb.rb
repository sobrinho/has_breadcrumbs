class Breadcrumb
  include ActionView::Helpers::TagHelper
  attr_accessor :items

  def initialize
    self.items = []
  end
  
  def add(name, url = nil, options = {})
    items << [name, url, options]
  end

  def display
    size = items.size

    crumbs = items.to_enum(:each_with_index).collect do |item, index|
      name, url, options = item

      options[:class] ||= ""
      options[:class] << " item-#{index}"
      options[:class] << " last" if size - 1 == index
      options[:class].squish!

      if url.nil? or size - 1 == index
        content_tag(:li, name, options)
      else
        content_tag(:li, content_tag(:a, name, :href => url), options)
      end
    end.join("\n")
    
    content_tag(:ul, "\n#{crumbs}\n".html_safe, :id => "breadcrumbs")
  end
end
