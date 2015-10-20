class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      #song title, author, url, timestamps
      t.string :title
      t.string :author
      t.string :url
      t.timestamps null: false
    end

    create_table :users do |t|
      t.string :username
      t.string :avatar_url
      t.string :email
      t.string :password
      t.timestamps null: false
    end
  end
end
