class AddSchedulerJobToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :scheduler_job, :string
  end
end
