class AddColumnuriToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :uri, :string
    add_column :competitions, :image, :string
  end
end
