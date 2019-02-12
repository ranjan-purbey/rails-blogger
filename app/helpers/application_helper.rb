module ApplicationHelper
  def full_title(title="")
    if not title.empty?
      title += "|"
    end
    "#{title}Blogger"
  end
end
