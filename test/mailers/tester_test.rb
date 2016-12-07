require 'test_helper'

class TesterTest < ActionMailer::TestCase
  test "travel" do
    mail = Tester.travel
    assert_equal "Travel", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
