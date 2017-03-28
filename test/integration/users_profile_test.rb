require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination', minimum:1
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end

  # follow unfollowのテスト
  test "reloationships test" do
    # フォロー前
    # プロフィールページ
    get user_path(@user)
    assert_select 'strong.stat#following', text: @user.following.count.to_s
    assert_select 'strong.stat#followers', text: @user.followers.count.to_s

    # Homeページ
    log_in_as(@user)
    get root_path
    assert_select 'strong.stat#following', text: @user.following.count.to_s
    assert_select 'strong.stat#followers', text: @user.followers.count.to_s

    # フォロー後
    @user.follow(@other_user)
    @other_user.follow(User.new)

    get user_path(@user)
    assert_select 'strong.stat#following', text: @user.following.count.to_s
    assert_select 'strong.stat#followers', text: @user.followers.count.to_s

    get root_path
    assert_select 'strong.stat#following', text: @user.following.count.to_s
    assert_select 'strong.stat#followers', text: @user.followers.count.to_s

    # アンフォロー
    @user.unfollow(@other_user)
    @other_user.unfollow(@user)

    get user_path(@user)
    assert_select 'strong.stat#following', text: @user.following.count.to_s
    assert_select 'strong.stat#followers', text: @user.followers.count.to_s

    log_in_as(@user)
    get root_path
    assert_select 'strong.stat#following', text: @user.following.count.to_s
    assert_select 'strong.stat#followers', text: @user.followers.count.to_s
  end
end