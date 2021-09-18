# frozen_string_literal: true

require 'test_helper'
require 'rails-controller-testing'
require 'rspec-rails'

class UserResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    password = "123456789asdfghxA"
    @user = User.create(username: 'note', email: 'note@mail.com', password: password, email_confirmed: true,
                        confirm_token: nil)
    @test_resource = @user.user_resources.create(name: 'file', desc: 'eleven', created_at: "2021-09-06 11:42:29.946328")
    @test_resource.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
    @test_resource.save

    post login_url params: { email: @user[:email], password: password }
  end

  test 'should get index' do
    get user_resources_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_resource_url
    assert_response :success
  end

  test 'should create user_resource' do
    assert_difference('UserResource.count') do
      post user_resources_url, params: { user_resource: { desc: 'and there is some good text here', name: 'another' } }
    end

    assert_redirected_to UserResource.last, params: { locale: 'en' }
  end

  test 'should show user_resource' do
    get registrations_index_url
    session[:user_id] = @user.id
    get user_resources_url
    assert([@test_resource], @user_resources)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_resource_url(id: @test_resource.id)
    assert_response :success
  end

  test 'should update user_resource' do
    patch user_resource_url @test_resource,
                            params: { user_resource: { desc: @test_resource.desc, name: @test_resource.name } }
    assert_redirected_to @test_resource, params: { locale: 'en' }
  end

  test 'should destroy user_resource' do
    assert_difference('UserResource.count', -1) do
      delete user_resource_url(@test_resource)
    end

    assert_redirected_to user_resources_url params: { locale: 'en' }
  end

  test 'Login' do
    password = 'Admin123'
    username = '10Head'
    user = User.create(username: username, email: 'Admin@5head.de', password: password, password_confirmation: password)

    post :"/login", params: { email: user[:email], password: user[password] }

    assert_nil session[:id]
    assert_response :success
  end
end
