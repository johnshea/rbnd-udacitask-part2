module Typeable
  attr_reader :type

  @type = ""

  def set_type(item_type)
    @type = item_type
  end

  def format_type
    "(#{@type.capitalize}) "
  end
end
