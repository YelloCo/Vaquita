class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :git_dir
      t.string :branch
      t.string :frequency
      t.string :time
      t.references :user, foreign_key: true
      t.string :last_commit

      t.timestamps
    end

    drop_table :repository_infos
  end
end
