module Listable
  def format_description(description)
    "#{description}".ljust(25)
  end

  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end

  def format_date(date1, date2 = nil)
    if date2 == nil
      date1 ? date1.strftime("%D") : "No due date"
    else
      dates = date1.strftime("%D") if date1
      dates << " -- " + date2.strftime("%D") if date2
      dates = "N/A" if !dates
      return dates
    end
  end
end
