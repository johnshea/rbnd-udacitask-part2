class TodoItem
  include Listable
  include Typeable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    set_type('todo')
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end

  def details
    format_type +
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end
end
