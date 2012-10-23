class CreateServerLogs < ActiveRecord::Migration
  def change
    create_table :server_logs do |t|

      t.timestamps
    end
  end
end
