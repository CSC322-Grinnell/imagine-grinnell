require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  def setup
    test_email = 'User@Test.com'
    test_password = 'This is just a test.'
    test_salt = 'salt'

    @valid_volunteer = Volunteer.new(
      email: test_email,
      password: test_password,
      salt: test_salt,
    )

    @no_email = Volunteer.new(
      password: test_password,
      salt: test_salt,
    )

    @no_password = Volunteer.new(
      email: test_email,
      salt: test_salt,
    )

    @no_salt = Volunteer.new(
      email: test_email,
      password: test_password,
    )

    @bad_email = Volunteer.new(
      email: 'bad email',
      password: test_password,
      salt: test_salt,
    )
  end

  # Valid Input Succeeds Test ==================================================

  test 'valid volunteer should be valid' do
    assert @valid_volunteer.valid?
  end

  # Field Presence Tests ==================================================

  test 'missing email should be invalid' do
    assert_not @no_email.valid?
  end

  test 'missing password should be invalid' do
    assert_not @no_password.valid?
  end

  test 'missing salt should be invalid' do
    assert_not @no_salt.valid?
  end

  # Other Validity Tests ==================================================

  test 'invalid email should be invalid' do
    assert_not @bad_email.valid?
  end

  test 'email should be saved as downcase' do
    expected_downcase = 'user@test.com'
    @valid_volunteer.save
    assert_equal expected_downcase, @valid_volunteer.email
  end
end
