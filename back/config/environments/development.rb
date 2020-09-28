Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :local

  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = {host: ENV["HOST"]}

  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: ENV["SMTP_ADDRESS"],
    port: ENV["SMTP_PORT"],
    domain: ENV["SMTP_DOMAIN"],
    authentication: ENV["SMTP_AUTHENTICATION"],
    user_name: ENV["EMAIL_USERNAME"],
    password: ENV["EMAIL_PASSWORD"],
    enable_starttls_auto: true
  }

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.active_record.verbose_query_logs = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
