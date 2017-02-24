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

  it 'will let a worker claim a job', js: true do
    job = create(:job)
    worker = create(:worker)
    login_as(worker, :scope => :worker)
    visit job_path(job)
    click_on 'Click here to claim it now.'
    expect(page).to have_content 'You have claimed this job'
  end

  it 'will let a worker say they are currently working on a job', js: true do
    worker = create(:worker)
    job = create(:job, pending: true, worker_id: worker.id)
    login_as(worker, :scope => :worker)
    visit job_path(job)
    click_link 'I\'m currently working on this job'
    expect(page).to have_content 'Mark as complete'
  end

  it 'will let a worker mark a job as complete', js: true do
    worker = create(:worker)
    job = create(:job, pending: true, current: true, worker_id: worker.id)
    login_as(worker, :scope => :worker)
    visit job_path(job)
    click_link 'Mark as complete'
    expect(page).to have_content 'This job is complete.'
  end
end
