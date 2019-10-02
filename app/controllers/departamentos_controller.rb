class DepartamentosController < ApplicationController
  before_action :set_departamento, only: [:show, :edit, :update, :destroy]

  # GET /departamentos
  # GET /departamentos.json
  def index
    @departamentos = Departamento.all
  end

  # GET /departamentos/1
  # GET /departamentos/1.json
  def show
    @produtos_por_departamento = Produto.where("departamento_id = ?",params[:id]).order(nome: :asc)
  end

  # GET /departamentos/new
  def new
    @departamento = Departamento.new
  end

  # GET /departamentos/1/edit
  def edit
  end

  # POST /departamentos
  # POST /departamentos.json
  def create
    @departamento = Departamento.new(departamento_params)

    
      if @departamento.save
        flash[:notice] = "Departamento Cadastrado com sucesso!"
        redirect_to departamentos_url
      else
        render :new 
      end
   
  end

  # PATCH/PUT /departamentos/1
  # PATCH/PUT /departamentos/1.json
  def update
    if @departamento.update departamento_params
      flash[:notice] = "Departamento atualizado com sucesso!"
      redirect_to departamentos_url
    else
      render :new 
    end
  end

  # DELETE /departamentos/1
  # DELETE /departamentos/1.json
  def destroy

      produto  = Produto.where('departamento_id = ?',@id)
       if  produto.size > 0
        flash[:error] = "Não foi possivel remover o departamento, porque existe produtos vinculado ao Departamento!"
        redirect_to departamentos_url
         return
       end
      @departamento.destroy
      flash[:notice] = "Departamento removido com sucesso!"
      redirect_to departamentos_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departamento
      @id = params[:id]
      @departamento = Departamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departamento_params
      params.require(:departamento).permit(:nome)
    end
end
