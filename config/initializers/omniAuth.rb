OmminAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['2676296335717134'], ENV['5bc8a2cc1ed1b5b69b2d915f4090bd76']
end
