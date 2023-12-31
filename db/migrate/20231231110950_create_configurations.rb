class CreateConfigurations < ActiveRecord::Migration[7.1]
  def change
    create_table :configurations do |t|
      t.string :spotify_access_token

      t.timestamps
    end
  end
end
