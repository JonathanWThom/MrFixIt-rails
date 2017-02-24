require 'rails_helper'

describe 'the worker path' do
  it 'will create a new worker' do
    visit new_worker_registration_path
    fill_in 'Email', :with => 'worker@worker.com'
    fill_in 'Password', :with => '123123'
    fill_in 'Password confirmation', :with => '123123'
    click_on 'Sign up'
    expect(page).to have_content("You're signed into your worker@worker.com worker account")
  end

  it 'will visit a worker\'s dashboard and show their jobs' do
    worker = create(:worker)
    job = create(:job, worker_id: worker.id, pending: true)
    login_as(worker, :scope => :worker)
    visit worker_path(worker)
    expect(page).to have_content('Job 1')
  end

  it 'will redirect a signed in worker' do
    worker = create(:worker)
    login_as(worker, :scope => :worker)
    visit new_worker_registration_path
    expect(page).to have_content("You are already signed in.")
  end

  it 'will sign out a user who tries to create a worker account' do
    user = create(:user)
    login_as(user)
    visit new_worker_registration_path
    expect(page).to have_content("You have been signed out of your user account.")
  end
end
