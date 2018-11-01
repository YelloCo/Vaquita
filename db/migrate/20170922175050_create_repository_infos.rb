class CreateRepositoryInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :repository_infos do |t|
      t.string :name
      t.string :last_commit

      t.timestamps
    end
  end
end
