# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ApexSite::Application.initialize!

#ApexSite::Application.configure do

#config.action_mailer.delivery_method = :smtp
#config.action_mailer.raise_delivery_errors = true

#ActionMailer::Base.smtp_settings = {
#  :address  => "smtp.7th-chapter.com",
#  :port  => 25,
#  :user_name  => "hbing@7th-chapter.com",
#  :password  => "bing7TH",
#  :authentication  => :login
#}
#config.action_mailer.smtp_settings = {
#:address => "local", :port => 25, :domain => "7th-chapter.com"
# address:      "smtp.gmail.com",
#port:         587,
#domain:       "gmail.com",
#authentication: "plain",
#user_name:    "h.bing612@gmail.com",
#password:     "bingGM9421",
#enable_starttls_auto: true
#}

#end
