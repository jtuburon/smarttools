class AddColumnuriToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :uri, :string
  end
end
