class Produto < ApplicationRecord

    belongs_to :departamento, optional: true

    validates :nome,  length: {minimum:4}
    validates :preco,:departamento, presence: true
end
