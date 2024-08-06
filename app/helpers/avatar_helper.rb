module AvatarHelper
  include MediaHelper
  def avatar_url(user)
    if user.avatar.present?
      image_url(user.avatar)
    else
      asset_path('default-avatar.png')
    end
  end
end
