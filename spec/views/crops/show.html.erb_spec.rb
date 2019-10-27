require 'rails_helper'

RSpec.describe "crops/show", type: :view do
  before(:each) do
    @crop = assign(:crop, Crop.create!(
      :produce => 2,
      :garden_id => 3,
      :planted_at => "Planted At",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Planted At/)
    expect(rendered).to match(/MyText/)
  end
end
