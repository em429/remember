module ApplicationHelper
  include Pagy::Frontend

  def nav_link_to(title, url)
    if current_page?(url)
      link_to(title, url, class: "active")
    else
      link_to(title, url)
    end
  end
  
  def render_account_dropdown
    if current_user
      render 'users/account_dropdown'
    elsif current_page?('/login')
      ""
    else
      link_to "Log in", login_path, class:"text-gray-800 hover:text-gray-500"
    end
  end
  
end
