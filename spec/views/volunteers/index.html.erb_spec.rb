require 'rails_helper'

RSpec.describe 'volunteers/index', type: :view do
  before(:each) do
    assign(:volunteers, [
             Volunteer.create!(
               :email => 'Email',
               :password => 'Password',
               :salt => 'Salt',
             ),
             Volunteer.create!(
               :email => 'Email',
               :password => 'Password',
               :salt => 'Salt',
             ),
           ],)
  end

  it 'renders a list of volunteers' do
    render
    assert_select 'tr>td', :text => 'Email'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Password'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Salt'.to_s, :count => 2
  end
end
