module RequestsHelper
  def request_thumbnail_url(request)
    if request.thumbnail.attached?
      url_for(request.thumbnail)
    else
      asset_path('freepik-lmao.jpg')
    end
  end
end
