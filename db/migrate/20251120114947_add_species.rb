class AddSpecies < ActiveRecord::Migration[8.1]
  def change
    add_column(:animals, :species, :string)
    add_column(:animals, :date_received, :date)
  end
end
