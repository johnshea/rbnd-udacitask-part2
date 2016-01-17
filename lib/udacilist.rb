class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase

    if ["todo", "event", "link"].include?(type)
      if type == "todo"
        if options.has_key?(:priority)
          if ["low", "medium", "high"].include?(options[:priority])
            @items.push TodoItem.new(description, options)
          else
            raise UdaciListErrors::InvalidPriorityValue
          end
        else
          @items.push TodoItem.new(description, options)
        end
      end
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link"
    else
      raise UdaciListErrors::InvalidItemType
    end
  end
  def delete(index)
    if index >= 0 and index < @items.length
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize
    end
  end
  def all
    display_header
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def filter(item_type)
    display_header
    @items_to_display = @items.select { |item| item.type == item_type }
    if @items_to_display.empty?
      puts "No items to display."
    else
      @items_to_display.each do |item|
        puts "#{item.details}"
      end
    end
  end

  private

  def display_header
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
  end

end
