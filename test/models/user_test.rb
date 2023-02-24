require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user with empty parameters" do
    user = User.new
    assert_not user.save
  end

  test "should not save user with whitespace as password" do
    user = User.new(username: "test", email: "t@test.com", password: "        ")
    assert_not user.save, "Saved user with whitespace as password"
  end
  
  test "should not save user with weak password" do
    user = User.new(username: "test", email: "t@test.com", password: "asdfasdf")
    assert_not user.save, "Saved user with weak password"
  end

  test "should not save user with invalid email" do
    user = User.new(username: "test", email: "test.com", password: "asdf1234")
    assert_not user.save, "Saved invalid email"
  end
  
  test "save valid user" do
    user = User.new(username: "test", email: "t@test.com", password: "asdf1234")
    assert user.save, "Couldn't save valid user"
  end

end
