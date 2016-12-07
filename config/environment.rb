# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


ActionMailer::Base.smtp_settings = {
  :user_name => 'Tjthekid',
  :password => 'Baddodo1',
  :domain => 'localhost',
  :address => 'smtp.sendgrid.net',
  :port => 465,
  :authentication => :plain,
  :enable_starttls_auto => true
}
