require 'rails_helper'

describe 'the jobs path' do
  it 'will allow a user to post a job' do
    user = create(:user)
    login_as(user)
    visit new_job_path
    fill_in 'Title', :with => 'Job 1'
    fill_in 'Description', :with => 'Job Description'
    click_on 'Create Job'
    expect(page).to have_content 'Job 1'
  end

  it 'will fail to post a job' do
    user = create(:user)
    login_as(user)
    visit new_job_path
    click_on 'Create Job'
    expect(page).to have_content 'Something went wrong!'
  end
  # 
  # it 'will let a worker claim a job', js: true do
  #   job = create(:job)
  #   worker = create(:worker, email: 'worker2@worker.com')
  #   visit new_worker_session_path
  #   fill_in 'Email', :with => 'worker2@worker.com'
  #   fill_in 'Password', :with => '123123'
  #   click_on 'Log in'
  #   visit jobs_path
  #   expect(page).to have_content 'I\'m currently working on this job.'
  # end
end
