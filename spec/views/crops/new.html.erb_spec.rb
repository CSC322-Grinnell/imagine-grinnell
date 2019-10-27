require 'rails_helper'

RSpec.describe "crops/new", type: :view do
  before(:each) do
    assign(:crop, Crop.new(
      :produce => 1,
      :garden_id => 1,
      :planted_at => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new crop form" do
    render

    assert_select "form[action=?][method=?]", crops_path, "post" do

      assert_select "input[name=?]", "crop[produce]"

      assert_select "input[name=?]", "crop[garden_id]"

      assert_select "input[name=?]", "crop[planted_at]"

      assert_select "textarea[name=?]", "crop[description]"
    end
  end
end
