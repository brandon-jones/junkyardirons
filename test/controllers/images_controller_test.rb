require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  setup do
    @image = images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image" do
    assert_difference('Image.count') do
      post :create, image: { bytes: @image.bytes, format: @image.format, height: @image.height, imageable_id: @image.imageable_id, imageable_type: @image.imageable_type, public_id: @image.public_id, secure_url: @image.secure_url, url: @image.url, width: @image.width }
    end

    assert_redirected_to image_path(assigns(:image))
  end

  test "should show image" do
    get :show, id: @image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @image
    assert_response :success
  end

  test "should update image" do
    patch :update, id: @image, image: { bytes: @image.bytes, format: @image.format, height: @image.height, imageable_id: @image.imageable_id, imageable_type: @image.imageable_type, public_id: @image.public_id, secure_url: @image.secure_url, url: @image.url, width: @image.width }
    assert_redirected_to image_path(assigns(:image))
  end

  test "should destroy image" do
    assert_difference('Image.count', -1) do
      delete :destroy, id: @image
    end

    assert_redirected_to images_path
  end
end
