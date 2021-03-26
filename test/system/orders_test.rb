require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Airtable", with: @order.airtable_id
    fill_in "Customer name", with: @order.customer_name
    fill_in "Name", with: @order.name
    fill_in "Status", with: @order.status
    click_on "Create Order"

    assert_text "Order was successfully created"
    assert_selector "h1", text: "Orders"
  end

  test "updating a Order" do
    visit order_url(@order)
    click_on "Edit", match: :first

    fill_in "Airtable", with: @order.airtable_id
    fill_in "Customer name", with: @order.customer_name
    fill_in "Name", with: @order.name
    fill_in "Status", with: @order.status
    click_on "Update Order"

    assert_text "Order was successfully updated"
    assert_selector "h1", text: "Orders"
  end

  test "destroying a Order" do
    visit edit_order_url(@order)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Order was successfully destroyed"
  end
end