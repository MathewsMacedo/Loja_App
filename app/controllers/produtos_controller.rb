class ProdutosController < ApplicationController

    before_action :set_produto, only: [:edit, :update, :destory]

    def index
        @produtos = Produto.order(nome: :asc)
        @produto_com_desconto = Produto.order(:preco).limit 1
    end

    def new
        @produto = Produto.new
        @departamentos = Departamento.order(nome: :asc)
    end 
    

    def update  
        if @produto.update produto_params
            flash[:notice] = "Produto atualizado com sucesso"
            redirect_to root_url 
        else
           renderizar :edit
        end
    end

    def edit
       renderizar :edit
    end

    def create
       @produto = Produto.new produto_params
        if @produto.save
            flash[:notice] = "Produto cadastrado com sucesso!"
            redirect_to root_url
        else 
           renderizar :new
        end      
    end

    def destroy 
        @produto.destroy
        redirect_to root_url
    end

    def busca
        @nome = params[:nome]
        @produtos = Produto.where "nome like ?",  "%#{@nome}%"
    end

    private

    def produto_params
        params.require(:produto).permit(:nome,:descricao,:preco,:quantidade, :departamento_id)
    end

    def set_produto
     @produto = Produto.find(params[:id])  
    end

    def renderizar(view)
        @departamentos = Departamento.all
        render view
    end

end
