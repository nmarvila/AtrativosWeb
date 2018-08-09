class CreateAtrativos < ActiveRecord::Migration
  def change
    create_table :atrativos do |t|
      t.string :nome
      t.string :endereco
      t.string :duracao
      t.integer :capacidade
      t.string :imagem
      t.float :ingresso_crianca
      t.float :ingresso_adulto
      t.references :pj, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
