module ApplicationHelper
  def page_title(page_title)
    base_title = "PivotalTracker Summary Reports"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  # Ref: http://railsapps.github.com/tutorial-rails-bootstrap-devise-cancan.html
  def display_errors resource, key=:base, show_full_message=false
    return '' if (resource.errors.empty?) or (resource.errors[key].empty?)
    if show_full_message
      messages = resource.errors[key].map { |msg| content_tag(:p, "#{key.to_s.humanize} #{msg}") }.join
    else
      messages = resource.errors[key].map { |msg| content_tag(:p, msg) }.join
    end
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end  
end
