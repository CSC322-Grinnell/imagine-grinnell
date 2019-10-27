require 'rails_helper'

RSpec.describe "crops/edit", type: :view do
  before(:each) do
    @crop = assign(:crop, Crop.create!(
      :produce => 1,
      :garden_id => 1,
      :planted_at => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit crop form" do
    render

    assert_select "form[action=?][method=?]", crop_path(@crop), "post" do

      assert_select "input[name=?]", "crop[produce]"

      assert_select "input[name=?]", "crop[garden_id]"

      assert_select "input[name=?]", "crop[planted_at]"

      assert_select "textarea[name=?]", "crop[description]"
    end
  end
end
