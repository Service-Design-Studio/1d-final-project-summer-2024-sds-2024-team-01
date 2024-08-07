module PdfDisplayHelper
  def document_url document
    case Rails.application.config.active_storage.service
    when :local
      return rails_blob_path(document, disposition: 'inline')
    when :google
      return "https://storage.googleapis.com/#{ENV['STORAGE_BUCKET_NAME']}/#{document.key}"
    end
  end
end

