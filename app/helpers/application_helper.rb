module ApplicationHelper
  include Pagy::Frontend

  def nav_link_to(title, url)
    if current_page?(url)
      link_to(title, url, class: "active")
    else
      link_to(title, url)
    end
  end
  
end
