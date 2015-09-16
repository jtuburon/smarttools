class AddUserToCompetitions < ActiveRecord::Migration
  def change
    add_reference :competitions, :user, index: true
  end
end
