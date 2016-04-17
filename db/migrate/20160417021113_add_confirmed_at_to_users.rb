class AddConfirmedAtToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :confirmed_at, :datetime
  	add_column :users, :confirmation_token, :string
  	add_column :users, :confirmation_sent_at, :datetime
  	add_column :users, :unconfirmed_email, :string 
  	add_column :users, :locked_at, :datetime
  	add_column :users,  :failed_attempts, :integer, :default => 0
  	add_index  :users, :confirmation_token, :unique => true 
    User.update_all(:confirmed_at => Time.now)
  end
end
