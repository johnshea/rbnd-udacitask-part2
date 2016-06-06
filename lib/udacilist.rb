class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase

    case type

      when "todo"
        if options.has_key?(:priority)
          if ["low", "medium", "high"].include?(options[:priority])
            @items.push TodoItem.new(description, options)
          else
            raise UdaciListErrors::InvalidPriorityValue
          end
        else
          @items.push TodoItem.new(description, options)
        end

      when "event"
        @items.push EventItem.new(description, options)

      when "link"
        @items.push LinkItem.new(description, options)

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

  def pretty_list
    rows = []
    # Build headers and blank line for table
    rows << ["?", "#", "Details"]
    rows << [" ", " ", " "]
    @items.each_with_index do |item, position|
      rows << ["_", position + 1, item.details]
    end
    puts Terminal::Table.new :rows => rows
  end

  def change_due_date(index, due_date)
    @items[index-1].change_due_date(due_date) if @items[index-1].type == 'todo'
  end

  private

  def display_header
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
  end

end
