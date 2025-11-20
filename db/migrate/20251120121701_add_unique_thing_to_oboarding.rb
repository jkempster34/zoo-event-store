class AddUniqueThingToOboarding < ActiveRecord::Migration[8.1]
  def change
    add_column(:onboardings, :unique_id, :string)
  end
end
