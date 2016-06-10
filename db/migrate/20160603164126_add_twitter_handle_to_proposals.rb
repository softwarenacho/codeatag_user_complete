class AddTwitterHandleToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :twitter_handle, :string
  end
end
