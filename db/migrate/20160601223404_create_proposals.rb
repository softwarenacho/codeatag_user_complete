class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :avatar

      t.timestamps null: false
    end
  end
end
