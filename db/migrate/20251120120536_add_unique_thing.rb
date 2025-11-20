class AddUniqueThing < ActiveRecord::Migration[8.1]
  def change
    add_column(:animals, :unique_id, :string)
  end
end
