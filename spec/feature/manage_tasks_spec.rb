require 'rails_helper'

def create_todo(title)
  fill_in 'todo_title', with: title
end

def submit_form
  page.execute_script("$('form').submit()")
end

feature 'Manage tasks', js: true do
  scenario 'add a new task' do
    # Point your browser towards the todo path
    visit todos_path

    # Enter description in the text field

    create_todo('Be Batman')
    # Press enter (to submit the form)
    submit_form

    # Expect the new task to be displayed in the list of tasks
    expect(page).to have_content('Be Batman')
  end

  scenario 'counter changes' do
    visit todos_path
    create_todo('Eat a cheese burger')
    submit_form
    # Wait for 1 second so the counter can be updated
    sleep(1)
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end

  scenario 'complete a task' do
    visit todos_path

    create_todo('task1')
    submit_form
    create_todo('task2')
    submit_form
    create_todo('task3')
    submit_form

    check('todo-1')
    check('todo-2')
    # Wait for 1 second so the counter can be updated
    sleep(1)

    expect( page.find(:css, 'span#total-count').text ).to eq "3"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"

  end
end
