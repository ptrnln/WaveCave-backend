class ChangeDurationToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :tracks, :duration, :float
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
