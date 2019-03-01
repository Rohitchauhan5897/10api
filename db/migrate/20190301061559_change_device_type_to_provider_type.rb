class ChangeDeviceTypeToProviderType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :socialauths, :device_type, :provider_type
  	rename_column :socialauths, :device_id, :provider_id
  end
end
