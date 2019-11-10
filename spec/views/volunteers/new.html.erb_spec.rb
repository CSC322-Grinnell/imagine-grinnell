require 'rails_helper'

RSpec.describe 'volunteers/new', type: :view do
  before(:each) do
    assign(:volunteer, Volunteer.new(
                         :email => 'MyString',
                         :password => 'MyString',
                         :salt => 'MyString',
                       ),)
  end

  it 'renders new volunteer form' do
    render

    assert_select 'form[action=?][method=?]', volunteers_path, 'post' do
      assert_select 'input[name=?]', 'volunteer[email]'

      assert_select 'input[name=?]', 'volunteer[password]'

      assert_select 'input[name=?]', 'volunteer[salt]'
    end
  end
end
