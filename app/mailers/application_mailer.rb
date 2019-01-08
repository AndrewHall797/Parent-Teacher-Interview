#Email class setup

class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"#Default sending address
  layout 'mailer'
end
