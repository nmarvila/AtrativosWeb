class CreatePjs < ActiveRecord::Migration
  def change
    create_table :pjs do |t|
      t.string :cnpj, :limit => 14, :null => false
      t.string :razao_social
      t.string :nome_fantasia
      t.string :email
      t.string :senha

      t.timestamps null: false
    end
  end
end
