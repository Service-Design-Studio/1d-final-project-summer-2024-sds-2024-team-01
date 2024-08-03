require 'rails_helper'

RSpec.describe RequestsHelper, type: :helper do
  describe '#request_thumbnail_url' do
    let(:request) { create(:request) }

    context 'when request has a thumbnail' do
      before do
        request.thumbnail.attach(
          io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar.png')),
          filename: 'default.png',
          content_type: 'image/png'
        )
      end
      it 'returns the URL for the user avatar' do
        expect(request_thumbnail_url(request)).to eq(url_for(request.thumbnail))
      end
    end

    context 'when user does not have an avatar' do
      it 'returns the path to the default avatar' do
        expect(request_thumbnail_url(request)).to eq(asset_path('freepik-lmao.jpg'))
      end
    end
  end
end
