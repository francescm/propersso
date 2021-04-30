class AddShibsessionToSession < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :shib_session, :string
  end
end
