require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = FactoryBot.create(:user)
  end

  test "should let successful signup" do
    visit root_url
    click_on 'Sign up now!'
    fill_in 'Username', with: 'test'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'asdf1234'
    fill_in 'Confirm password', with: 'asdf1234'
    click_on 'Create User'
    assert page.has_content? 'Profile'
  end

  test "should let valid login" do
    visit root_url
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button "Log in"
    assert page.has_content? @user.email 
  end

  test "should not let invalid login" do
    visit root_url
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'asdfasdf123'
    click_on 'Log in'
    assert page.has_content? 'Invalid' 
  end

  test "should not let blank signup" do
    visit root_url
    
    click_on 'Sign up now!'
    click_on 'Create User'
    assert page.has_content? '5 errors prohibited this user from being saved:' 
    fill_in 'Username', with: 'asd'
    click_on 'Create User'
    assert page.has_content? '4 errors prohibited this user from being saved:' 
  end

  test "should not let empty password signup" do
    visit root_url
    
    click_on 'Sign up now!'
    fill_in 'Username', with: 'asd'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '        '
    fill_in 'Confirm password', with: '        '
    click_on 'Create User'
    assert page.has_content? "Password must be 8+ characters and must include a number" 
  end

end
