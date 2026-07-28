require "test_helper"

class SalonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salon = salons(:one)
  end

  test "should get index" do
    get salons_url
    assert_response :success
  end

  test "should get new" do
    get new_salon_url
    assert_response :success
  end

  test "should create salon" do
    assert_difference("Salon.count") do
      post salons_url, params: { salon: { area: @salon.area, name: @salon.name, phone_number: @salon.phone_number } }
    end
    assert_redirected_to salon_url(Salon.last)
  end

  test "should show salon" do
    get salon_url(@salon)
    assert_response :success
  end

  test "should get edit" do
    get edit_salon_url(@salon)
    assert_response :success
  end

  test "should update salon" do
    patch salon_url(@salon), params: { salon: { area: @salon.area, name: @salon.name, phone_number: @salon.phone_number } }
    assert_redirected_to salon_url(@salon)
  end

  test "should destroy salon without treatments" do
    salon = Salon.create!(name: "削除用サロン", area: "テストエリア", phone_number: "00-0000-0000")
    assert_difference("Salon.count", -1) do
      delete salon_url(salon)
    end
    assert_redirected_to salons_url
  end

  test "should not destroy salon with treatments" do
    assert_no_difference("Salon.count") do
      delete salon_url(@salon)
    end
  end
end
