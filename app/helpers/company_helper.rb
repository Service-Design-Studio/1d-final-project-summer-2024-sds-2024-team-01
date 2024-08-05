module CompanyHelper
  def company_image_url(company)
    include MediaHelper
    if company.image.present?
      image_url(company.image)
    else
      asset_path('company.jpg')
    end
  end
end
