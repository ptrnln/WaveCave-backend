# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.reloader.to_prepare do
    ActiveStorage::Blob
end
Rails.application.initialize!

Jbuilder.key_format camelize: :lower
Jbuilder.deep_format_keys true
