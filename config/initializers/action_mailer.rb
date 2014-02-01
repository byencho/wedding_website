# Note: symbolize_keys is required to convert Hashie objects from the Choices gem into hashes with
# symbolized keys for ActionMailer.
#
ActionMailer::Base.default_url_options = Rails.configuration.action_mailer.default_url_options.to_hash.symbolize_keys!
ActionMailer::Base.delivery_method = Rails.configuration.action_mailer.delivery_method
ActionMailer::Base.smtp_settings = Rails.configuration.action_mailer.smtp_settings.to_hash.symbolize_keys!