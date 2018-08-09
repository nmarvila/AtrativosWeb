class CreateEntradas < ActiveRecord::Migration
  def change
    create_table :entradas do |t|
      t.string :tipo
      t.date :data
      t.references :atrativo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
