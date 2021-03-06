require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:post1)
    @user = users(:user1)
    @category = categories(:category1)

    @current_user = @user
    session[:user_id] = @current_user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { user_id: @post.user.id, text: @post.text, title: @post.title, category_id: @post.category.id }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    put :update, id: @post, post: { user_id: @post.user.id, text: @post.text, title: @post.title, category_id: @post.category.id }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end

  test 'post search by category' do
    put :search_by_category, :search => { :category_id => 1 }
    assert_response :success
  end

  test 'post search by user' do
    put :search_by_user, :search => { :search => 'test2' }
    assert_response :success
  end

  test 'post search by content' do
    put :search_by_content, :search => { :search => 'test2' }
    assert_response :success
  end
end
