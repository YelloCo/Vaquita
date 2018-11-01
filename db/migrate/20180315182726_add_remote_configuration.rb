class AddRemoteConfiguration < ActiveRecord::Migration[5.1]
  def up
    add_column :repositories, :remote_repository, :boolean, default: false
    add_column :repositories, :remote_type, :string, default: nil
    add_column :repositories, :remote_url, :string, default: nil
    add_column :repositories, :remote_token, :string, default: nil
    Repository.unscoped.all.update_all(remote_repository: false)
  end

  def down
    remove_column :repositories, :remote_repository
    remove_column :repositories, :remote_type
    remove_column :repositories, :remote_url
    remove_column :repositories, :remote_token
  end
end
