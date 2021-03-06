require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get new" do
    get :new
    assert_response :success
  end

  test "user creation" do
    # Missing username
    assert_no_difference("User.count") do
      post :create, :user => {:password => 'testing', :password_confirmation => 'testing'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Missing password
    assert_no_difference("User.count") do
      post :create, :user => {:username => 'user', :password_confirmation => 'testing'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Missing password confirmation
    assert_no_difference("User.count") do
      post :create, :user => {:username => 'user', :password => 'testing'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Username too short
    assert_no_difference("User.count") do
      post :create, :user => {:username => 'a', :password => 'testing', :password_confirmation => 'testing'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Username already exists
    assert_no_difference("User.count") do
      post :create, :user => {:username => 'test', :password => 'testing', :password_confirmation => 'testing'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Username too short
    assert_no_difference("User.count") do
      post :create, :user => {:username => 'a', :password => 'testing', :password_confirmation => 'testing'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Passwords do not match
    assert_no_difference("User.count") do
      post :create, :user => {:username => 'user', :password => 'testing', :password_confirmation => 'testing2'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Password too short
    assert_no_difference("User.count") do
      post :create, :user => {:username => 'user', :password => 'test', :password_confirmation => 'test'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Password too long
    assert_no_difference("User.count") do
      post :create, :user => {:username => 'user', :password => 'abcde12345abcde12345abcde12345abcde', :password_confirmation => 'abcde12345abcde12345abcde12345abcde'}
    end
    assert_equal flash[:notice], "Form is invalid"

    # Should create user
    assert_difference("User.count") do
      post :create, :user => {:username => 'newuser', :password => 'password', :password_confirmation => 'password'}
    end
    assert_equal flash[:notice], "You signed up successfully"

  end

  test "make admin" do
    @user = users(:user1)
    @current_user = @user
    session[:user_id] = @current_user.id

    put(:make_admin, 'id' => "2")
    assert_equal users(:user2).is_admin, true
  end



  test "revoke admin" do
    @user = users(:user1)
    @current_user = @user
    session[:user_id] = @current_user.id

    put(:revoke_admin, 'id' => "2")
    assert_equal users(:user2).is_admin, false
  end

  test "admin tries to grant admin access to oneself" do
    @user = users(:user1)
    @current_user = @user
    session[:user_id] = @current_user.id

    put(:make_admin, 'id' => "1")
    assert_redirected_to users_path
    assert_equal users(:user1).is_admin, true
  end

  test "admin tries to revoke admin access to oneself" do
    @user = users(:user1)
    @current_user = @user
    session[:user_id] = @current_user.id

    put(:revoke_admin, 'id' => "1")
    assert_redirected_to users_path
    assert_equal users(:user1).is_admin, true
  end

end
