class CreateRawApiTables < ActiveRecord::Migration
  def change
    create_table :champion_api_data do |t|
      t.references :champion, index: true
      t.json       :raw_api_data

      t.timestamps
    end

    create_table :match_api_data do |t|
      t.references :match, index: true
      t.json       :raw_api_data

      t.timestamps
    end

    add_foreign_key :champion_api_data, :champions, name: 'fk_rails_champion_api_data_champions', on_delete: :cascade
    add_foreign_key :match_api_data, :matches, name: 'fk_rails_match_api_data_matches', on_delete: :cascade

    execute %{
      insert into champion_api_data
      (champion_id, raw_api_data, created_at, updated_at)
        (
          select id, raw_api_data, created_at, updated_at
          from champions
        );

      insert into match_api_data
      (match_id, raw_api_data, created_at, updated_at)
        (
          select id, raw_api_data, created_at, updated_at
          from matches
        );
    }

    remove_column :champions, :raw_api_data
    remove_column :matches, :raw_api_data
  end
end
