class EnableExtensions < ActiveRecord::Migration[5.0]
  def change
    # Disabled for now
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    enable_extension 'hstore' unless extension_enabled?('hstore')
  end
end
