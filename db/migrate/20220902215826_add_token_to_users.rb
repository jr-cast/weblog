class AddTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :authentication_token, :string
    add_index :users, :authentication_token, :unique => true

    User.find_each do |u|
      puts "generate user #{u.id} token"
      u.generate_authentication_token
      u.save!
    end
  end
end
