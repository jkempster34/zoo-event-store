class AddCites < ActiveRecord::Migration[8.1]
  def change
    add_column :onboardings, :cites_certificate_present, :boolean, default: true
  end
end
