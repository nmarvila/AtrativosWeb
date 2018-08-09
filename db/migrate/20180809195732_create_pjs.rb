class CreatePjs < ActiveRecord::Migration
  def change
    create_table :pjs do |t|
      t.column :cnpj, :string, :limit => 14, :null => false
      t.column :razao_social, :string
      t.column :nome_fantasia, :string
      t.column :email, :string
      t.column :senha, :string

      t.timestamps null: false
    end
  end
end
