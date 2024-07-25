require 'rails_helper'

RSpec.describe AvatarHelper, type: :helper do
  describe '#avatar_url' do
    let(:user) { create(:user) }

    context 'when user has an avatar' do
      before do
        user.avatar.attach(
          io: File.open(Rails.root.join('app', 'assets', 'images', 'default-avatar.png')),
          filename: 'default.png',
          content_type: 'image/png'
        )
      end
      it 'returns the URL for the user avatar' do
        expect(avatar_url(user)).to eq(url_for(user.avatar))
      end
    end

    context 'when user does not have an avatar' do
      it 'returns the path to the default avatar' do
        expect(avatar_url(user)).to eq(asset_path('default-avatar.png'))
      end
    end
  end
end
