require "test_helper"

class ApplyJobMailerTest < ActionMailer::TestCase
  test "create_apply" do
    mail = ApplyJobMailer.create_apply
    assert_equal "Create apply", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
