class CreateFuncionarios < ActiveRecord::Migration
  def change
    create_table :funcionarios do |t|
      t.string :cpf, :limit => 11, :null => false
      t.string :nome
      t.string :cargo
      t.string :email
      t.string :senha
      t.references :pj, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
