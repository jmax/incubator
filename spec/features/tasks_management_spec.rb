require "spec_helper"

feature "Tasks Management" do
  given!(:task) {
    Task.create(
      title: "Some title",
      description: "Some description"
    )
  }

  background do
    visit "/tasks"
  end

  scenario "Listing tasks" do
    expect(page).to have_content(task.title)
    expect(page).to have_content(task.description)
  end

  scenario "Task detail page" do
    click_on task.title

    expect(page).to have_content(task.title)
    expect(page).to have_content(task.description)
  end

  scenario "Creating a new task with valid data" do
    click_on "Add new Task"

    fill_in "task[title]",       with: "Foo"
    fill_in "task[description]", with: "Bar"

    click_on "Save"

    expect(Task.where(title: "Foo")).to exist
    expect(current_path).to eql("/tasks")
    expect(page).to have_content("Task was successfully created.")
  end

  scenario "Creating a new task with invalid data" do
    click_on "Add new Task"

    click_on "Save"

    expect(Task.where(title: "")).not_to exist
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Updating an existing task with valid data" do
    click_on "Edit"

    fill_in "task[title]", with: "Foo"

    expect{
      click_on "Save"
    }.to change{task.reload.title}.from("Some title").to("Foo")

    expect(current_path).to eql("/tasks/#{task.id}")
    expect(page).to have_content("ask was successfully updated.")
  end

  scenario "Updating an existing task with invalid data" do
    click_on "Edit"

    fill_in "task[title]",       with: ""

    expect{
      click_on "Save"
    }.not_to change{task.reload.title}.from("Some title").to("")

    expect(page).to have_content("Title can't be blank")
  end

  scenario "Removing an existing task" do
    click_on "Delete"

    expect(Task.all).to be_empty
    expect(current_path).to eql("/tasks")
    expect(page).to have_content("Task was successfully destroyed.")
  end
end
