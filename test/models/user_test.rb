# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should return email when name empty' do
    user = User.new(email: 'alice@example.com', name: '')
    assert_equal 'alice@example.com', user.name_or_email

    user.name = 'alice'
    assert_equal 'alice', user.name_or_email
  end
end
