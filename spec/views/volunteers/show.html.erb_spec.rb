require 'rails_helper'

RSpec.describe 'volunteers/show', type: :view do
  before(:each) do
    @volunteer = assign(:volunteer, Volunteer.create!(
                                      :email => 'Email',
                                      :password => 'Password',
                                      :salt => 'Salt',
                                    ),)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/Salt/)
  end
end
