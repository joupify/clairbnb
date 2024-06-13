# spec/support/carrierwave.rb
require 'carrierwave/test/matchers'


RSpec.configure do |config|
  config.include CarrierWave::Test::Matchers

  config.after(:each) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end
  end
end

CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
  config.root = "#{Rails.root}/spec/support"
end
