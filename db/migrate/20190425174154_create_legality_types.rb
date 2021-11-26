class CreateLegalityTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :legality_types do |t|
      t.text :name, null: false
      t.text :code, null: false

      t.timestamps
    end

    create_table :deck_formats do |t|
      t.text :name, null: false
      t.text :code, null: false

      t.timestamps
    end

    create_table :legalities do |t|
      t.references :legality_type, type: :integer, index: true, foreign_key: true
      t.references :deck_format, type: :integer, index: true, foreign_key: true
      t.references :card, type: :integer, index: true, foreign_key: true

      t.timestamps
    end
  end
end
