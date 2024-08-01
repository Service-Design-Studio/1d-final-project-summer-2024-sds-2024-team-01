module CompanyHelper
  def company_image_url(company)
    if company.image.present?
      url_for(company.image)
    else
      asset_path('company.jpg')
    end
  end
end
