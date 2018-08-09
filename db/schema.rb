# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180809204559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atrativos", force: :cascade do |t|
    t.string   "nome"
    t.string   "endereco"
    t.string   "duracao"
    t.integer  "capacidade"
    t.string   "imagem"
    t.float    "ingresso_crianca"
    t.float    "ingresso_adulto"
    t.integer  "pj_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "atrativos", ["pj_id"], name: "index_atrativos_on_pj_id", using: :btree

  create_table "entradas", force: :cascade do |t|
    t.string   "tipo"
    t.date     "data"
    t.integer  "atrativo_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "entradas", ["atrativo_id"], name: "index_entradas_on_atrativo_id", using: :btree

  create_table "funcionarios", force: :cascade do |t|
    t.string   "cpf",        limit: 11, null: false
    t.string   "nome"
    t.string   "cargo"
    t.string   "email"
    t.string   "senha"
    t.boolean  "esta_ativa"
    t.integer  "pj_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "funcionarios", ["pj_id"], name: "index_funcionarios_on_pj_id", using: :btree

  create_table "pjs", force: :cascade do |t|
    t.string   "cnpj",          limit: 14, null: false
    t.string   "razao_social"
    t.string   "nome_fantasia"
    t.string   "email"
    t.string   "senha"
    t.boolean  "esta_ativa"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "atrativos", "pjs"
  add_foreign_key "entradas", "atrativos"
  add_foreign_key "funcionarios", "pjs"
end
