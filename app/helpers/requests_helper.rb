module RequestsHelper
  include MediaHelper
  def request_thumbnail_url(request)
    if request.thumbnail.attached?
      image_url(request.thumbnail)
    else
      asset_path('freepik-lmao.jpg')
    end
  end
end
