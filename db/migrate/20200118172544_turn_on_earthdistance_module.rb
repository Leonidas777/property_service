class TurnOnEarthdistanceModule < ActiveRecord::Migration[6.0]
  def change
    def up
      execute 'create extension if not exists cube;
               create extension if not exists earthdistance;'
    end

    def down
      execute 'drop extension if exists earthdistance;
               drop extension if exists cube;'
    end
  end
end
