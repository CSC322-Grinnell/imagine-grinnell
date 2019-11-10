require 'rails_helper'

RSpec.describe 'crops/index', type: :view do
  before(:each) do
    assign(:crops, [
             Crop.create!(
               :produce => 2,
               :garden_id => 3,
               :planted_at => 'Planted At',
               :description => 'MyText',
             ),
             Crop.create!(
               :produce => 2,
               :garden_id => 3,
               :planted_at => 'Planted At',
               :description => 'MyText',
             ),
           ],)
  end

  it 'renders a list of crops' do
    render
    assert_select 'tr>td', :text => 2.to_s, :count => 2
    assert_select 'tr>td', :text => 3.to_s, :count => 2
    assert_select 'tr>td', :text => 'Planted At'.to_s, :count => 2
    assert_select 'tr>td', :text => 'MyText'.to_s, :count => 2
  end
end
