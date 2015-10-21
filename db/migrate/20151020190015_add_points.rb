class AddPoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      #song title, author, url, timestamps
      t.references :user
      t.references :song
      t.timestamps null: false
    end
  end
end
