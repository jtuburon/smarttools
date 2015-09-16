class AddColumns01ToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :o_video, :string
    add_column :videos, :c_video, :string
    add_column :videos, :converted_at, :timestamp
  end
end
