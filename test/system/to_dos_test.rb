require "application_system_test_case"

class ToDosTest < ApplicationSystemTestCase
  setup do
    @to_do = to_dos(:one)
  end

  test "visiting the index" do
    visit to_dos_url
    assert_selector "h1", text: "To dos"
  end

  test "should create to do" do
    visit to_dos_url
    click_on "New to do"

    fill_in "Created at", with: @to_do.created_at
    fill_in "Dead line", with: @to_do.dead_line
    fill_in "Task", with: @to_do.task_id
    fill_in "Task name", with: @to_do.task_name
    fill_in "User", with: @to_do.user_id
    click_on "Create To do"

    assert_text "To do was successfully created"
    click_on "Back"
  end

  test "should update To do" do
    visit to_do_url(@to_do)
    click_on "Edit this to do", match: :first

    fill_in "Created at", with: @to_do.created_at
    fill_in "Dead line", with: @to_do.dead_line
    fill_in "Task", with: @to_do.task_id
    fill_in "Task name", with: @to_do.task_name
    fill_in "User", with: @to_do.user_id
    click_on "Update To do"

    assert_text "To do was successfully updated"
    click_on "Back"
  end

  test "should destroy To do" do
    visit to_do_url(@to_do)
    click_on "Destroy this to do", match: :first

    assert_text "To do was successfully destroyed"
  end
end
