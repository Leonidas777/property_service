class TurnOnEarthdistanceModule < ActiveRecord::Migration[6.0]
  def change
    def up
      execute 'CREATE EXTENSION IF NOT EXISTS cube;
               CREATE EXTENSION IF NOT EXISTS earthdistance;

               CREATE EXTENSION IF NOT EXISTS btree_gist;
               CREATE INDEX IF NOT EXISTS properties_lat_lng ON properties USING gist(ll_to_earth(lat, lng));'

      add_index :properties, %i[property_type offer_type]
    end

    def down
      execute 'DROP EXTENSION IF EXISTS earthdistance;
               DROP EXTENSION IF EXISTS cube;

               DROP EXTENSION IF EXISTS btree_gist;
               DROP INDEX IF EXISTS properties_lat_lng;'

      remove_index :properties, %i[property_type offer_type]
    end
  end
end
