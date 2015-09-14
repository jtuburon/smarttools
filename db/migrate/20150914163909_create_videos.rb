class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :user_email
      t.string :user_name
      t.string :user_lastname
      t.column :status, :integer, default: 0
      t.timestamps null: false
    end
    add_reference :videos, :competition, index: true
  end
end
