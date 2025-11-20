class AddQuarantineFieldsToOnboarding < ActiveRecord::Migration[8.1]
  def change
    add_column :onboardings, :quarantine_started_at, :datetime
    add_column :onboardings, :quarantine_location, :string
  end
end
