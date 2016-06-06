class LinkItem
  include Listable
  include Typeable
  attr_reader :description, :site_name

  def initialize(url, options={})
    set_type('link')
    @description = url
    @site_name = options[:site_name]
  end

  def format_name
    @site_name ||= ''
  end

  def details
    format_type + format_description(@description) + "site name: " + format_name
  end
end
