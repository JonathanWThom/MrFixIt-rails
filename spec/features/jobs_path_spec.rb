require 'rails_helper'

describe 'the jobs path' do
  before() do
    @job = create(:job)
  end
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
    worker = create(:worker)
    login_as(worker, :scope => :worker)
    visit job_path(@job)
    click_on 'Click here to claim it now.'
    expect(page).to have_content 'You have claimed this job'
  end
end
