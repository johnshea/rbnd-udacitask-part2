class EventItem
  include Listable
  include Typeable
  attr_reader :description, :start_date, :end_date

  def initialize(description, options={})
    set_type('event')
    @description = description
    @start_date = Date.parse(options[:start_date]) if options[:start_date]
    @end_date = Date.parse(options[:end_date]) if options[:end_date]
  end

  def details
    format_type + format_description(@description) + "event dates: " + format_date(@start_date, @end_date)
  end
end
