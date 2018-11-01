class AddEmailsFieldToRepositories < ActiveRecord::Migration[5.1]
  def change
    add_column :repositories, :notification_emails, :text
  end
end
