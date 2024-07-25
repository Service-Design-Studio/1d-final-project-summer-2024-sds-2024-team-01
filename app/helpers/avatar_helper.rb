module AvatarHelper
  def avatar_url(user)
    if user.avatar.present?
      url_for(user.avatar)
    else
      asset_path('default-avatar.png')
    end
  end
end
