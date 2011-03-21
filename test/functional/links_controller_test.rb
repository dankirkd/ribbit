require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:kirkdorffer)
    sign_in @user
    @link = links(:google)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create link" do
    assert_difference('Link.count') do
      post :create, :link => @link.attributes
    end

    assert_redirected_to links_url
  end

  test "should get edit" do
    get :edit, :id => @link.to_param
    assert_response :success
  end

  test "should update link" do
    put :update, :id => @link.to_param, :link => @link.attributes
    assert_redirected_to links_url
  end

  test "should destroy link" do
    assert_difference('Link.count', -1) do
      delete :destroy, :id => @link.to_param
    end

    assert_redirected_to links_url
  end

  test "should vote for a link" do
    put :upvote, :id => @link.to_param, :link => @link.attributes

    vote = Vote.where("votes.link_id = ? AND votes.email = ?", @link.to_param, @user.email).first
    assert_equal vote.total, 1

    assert_redirected_to links_url
  end

  test "should vote against a link" do
    put :downvote, :id => @link.to_param, :link => @link.attributes

    vote = Vote.where("votes.link_id = ? AND votes.email = ?", @link.to_param, @user.email).first
    assert_equal vote.total, -1

    assert_redirected_to links_url
  end
end
