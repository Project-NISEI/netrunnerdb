# Adds unique indexes for key entities.
class AddUniqueIndexesForCards < ActiveRecord::Migration[5.1]
  def change
    add_index :sides, :code, unique: true
    add_index :factions, :code, unique: true
    add_index :card_types, :code, unique: true
    add_index :subtypes, :code, unique: true
    add_index :nr_cycles, :code, unique: true
    add_index :nr_set_types, :code, unique: true
    add_index :nr_sets, :code, unique: true
    add_index :cards, :code, unique: true
    add_index :printings, :code, unique: true
    add_index :legality_types, :code, unique: true
    add_index :deck_formats, :code, unique: true
    add_index :legalities, [:deck_format_id, :card_id], unique: true
  end
end
