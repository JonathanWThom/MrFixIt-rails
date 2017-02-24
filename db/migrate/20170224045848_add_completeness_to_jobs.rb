class AddCompletenessToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :complete, :boolean, :default => false
    add_column :jobs, :current, :boolean, :default => false
  end
end
