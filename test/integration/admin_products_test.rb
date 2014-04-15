
require 'test_helper'

class AdminProductsTest < ActionDispatch::IntegrationTest
  def test_manage
    visit "/admin/login"
    fill_in "Email", with: 'admin@example.com'
    fill_in "Password", with: 'test'
    click_on "Log In"

    click_on "New Product"
    fill_in "Name", with: "Awesome"
    fill_in "Price", with: "9.99"
    click_on "Save"

    assert page.has_content?(/Product.*was created/)
    click_on "Awesome"
    assert page.has_content?('9.99')
    click_on "Edit"

    fill_in "Price", with: "18.99"
    click_on "Save"

    click_on "Awesome"
    assert page.has_content?('18.99')
    click_on "Delete"

    refute page.has_content?('Awesome')
  end
end
