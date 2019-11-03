require 'test_helper'

class CropTest < ActiveSupport::TestCase
  def setup
    test_produce_type = 1234
    test_garden_id = 5678
    test_planted_at = "June 1, 2019"
    test_description = "blahblahblah"

    @valid_crop = Crop.new(
      produce: test_produce_type,
      garden_id: test_garden_id,
      planted_at: test_planted_at,
      description: test_description
    )

    @no_produce = Crop.new(
      garden_id: test_garden_id,
      planted_at: test_planted_at,
      description: test_description
    )

    @no_garden_id = Crop.new(
      produce: test_produce_type,
      planted_at: test_planted_at,
      description: test_description
    )

    @no_planted_at = Crop.new(
      produce: test_produce_type,
      garden_id: test_garden_id,
      description: test_description
    )

    @no_description = Crop.new(
      produce: test_produce_type,
      garden_id: test_garden_id,
      planted_at: test_planted_at
    )
  end

  # Valid Input Succeeds Test ==================================================

  test "valid crop should be valid" do
    assert @valid_crop.valid?
  end

  # Field Presence Tests ==================================================

  test "missing description should be valid" do
    assert @no_description.valid?
  end

  test "missing produce should be invalid" do
    assert_not @no_produce.valid?
  end

  test "missing garden id should be invalid" do
    assert_not @no_garden_id.valid?
  end

  test "missing planted at should be invalid" do
    assert_not @no_planted_at.valid?
  end
end
