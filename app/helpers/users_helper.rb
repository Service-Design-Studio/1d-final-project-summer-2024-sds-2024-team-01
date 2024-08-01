module UsersHelper
  def user_avatar_url(user)
    if user.avatar.attached?
      url_for(user.avatar)
    else
      asset_path('default-avatar.png') 
    end
  end
end