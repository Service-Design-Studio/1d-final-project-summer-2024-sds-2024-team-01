# spec/support/active_storage_mock.rb
RSpec.configure do |config|
          config.before(:each) do
            allow_any_instance_of(ActiveStorage::Attached::One).to receive(:attach).and_return(true)
            allow_any_instance_of(ActiveStorage::Attached::One).to receive(:attached?).and_return(true)
            allow_any_instance_of(ActiveStorage::Attached::One).to receive(:purge_later).and_return(true)
          end
        end
        