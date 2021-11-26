class CreatePrintings < ActiveRecord::Migration[5.1]
  def change
    create_table :nr_cycles do |t|
      t.text :code, null: false
      t.text :name, null: false
      t.text :description

      t.timestamps
    end

    create_table :nr_set_types do |t|
      t.text :code, null: false
      t.text :name, null: false
      t.text :description

      t.timestamps
    end

    create_table :nr_sets do |t|
      t.text :code, null: false
      t.text :name, null: false
      t.date :date_release
      t.integer :size
      t.references :nr_cycle, type: :integer, index: true, foreign_key: true
      t.references :nr_set_type, type: :integer, index: true, foreign_key: true

      t.timestamps
    end

    create_table :printings do |t|
      t.text :printed_text
      t.boolean :printed_uniqueness
      t.text :code
      t.text :flavor
      t.text :illustrator
      t.integer :position
      t.integer :quantity
      t.date :date_release
      t.references :card, type: :integer, index: true, foreign_key: true
      t.references :nr_set, type: :integer, index: true, foreign_key: true

      t.timestamps
    end
  end
end
