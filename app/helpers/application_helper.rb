module ApplicationHelper
  def page_title(page_title)
    base_title = "PivotalTracker Summary Reports"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
