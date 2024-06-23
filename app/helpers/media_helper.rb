# Referred from https://github.com/GoogleCloudPlatform/ruby-docs-samples.git
module MediaHelper
  def image_url photo
    case Rails.application.config.active_storage.service
    when :local
      return url_for photo
    when :google
      return "https://storage.googleapis.com/#{ENV['STORAGE_BUCKET_NAME']}/#{photo.thumbnail.key}"
    end
  end
end
