if Rails.env.production?
  CarrierWave.configure do |config|
    config.dropbox_app_key = ENV["DX_APP_KEY"]
    config.dropbox_app_secret = ENV["DX_APP_SECRET"]
    config.dropbox_access_token = ENV["DX_ACCESS_TOKEN"]
    config.dropbox_access_token_secret = ENV["DX_ACCESS_TOKEN_SECRET"]
    config.dropbox_user_id = ENV["DX_USER_ID"]
    config.dropbox_access_type = "app_folder"
  end
end
