class Atrativo < ActiveRecord::Base
    belongs_to :pj
    has_many :entradas
end
