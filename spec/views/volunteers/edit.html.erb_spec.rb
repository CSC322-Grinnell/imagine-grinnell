require 'rails_helper'

RSpec.describe 'volunteers/edit', type: :view do
  before(:each) do
    @volunteer = assign(:volunteer, Volunteer.create!(
                                      :email => 'MyString',
                                      :password => 'MyString',
                                      :salt => 'MyString',
                                    ),)
  end

  it 'renders the edit volunteer form' do
    render

    assert_select 'form[action=?][method=?]', volunteer_path(@volunteer), 'post' do
      assert_select 'input[name=?]', 'volunteer[email]'

      assert_select 'input[name=?]', 'volunteer[password]'

      assert_select 'input[name=?]', 'volunteer[salt]'
    end
  end
end
