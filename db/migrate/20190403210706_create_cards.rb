class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :sides do |t|
      t.text :code, null: false
      t.text :name, null: false

      t.timestamps
    end

    create_table :card_types do |t|
      t.text :code, null: false
      t.text :name, null: false

      t.timestamps
    end

    create_table :subtypes do |t|
      t.text :code, null: false
      t.text :name, null: false

      t.timestamps
    end

    create_table :factions do |t|
      t.text :code, null: false
      t.boolean :is_mini, null: false
      t.text :name, null: false

      t.timestamps
    end

    create_table :cards do |t|
      t.integer :advancement_requirement
      t.integer :agenda_points
      t.integer :base_link
      t.text :code, null: false
      t.integer :cost
      t.integer :deck_limit
      t.references :faction, type: :integer, index: true, foreign_key: true
      t.integer :influence_cost
      t.integer :influence_limit
      t.integer :memory_cost
      t.integer :minimum_deck_size
      t.text :name, null: false
      t.references :side, type: :integer, index: true, foreign_key: true
      t.integer :strength
      t.text :subtypes
      t.text :text
      t.integer :trash_cost
      t.references :card_type, type: :integer, index: true, foreign_key: true
      t.boolean :uniqueness

      t.timestamps
    end

    create_table :cards_subtypes, id: false do |t|
      t.integer :card_id, null: false
      t.integer :subtype_id, null: false, index: true
    end
  end
end
