class FuncionariosController < ApplicationController
  before_action :set_funcionario, only: [:show, :edit, :update, :destroy]
  
  def index
    @funcionarios = Funcionario.all
  end

  def show
  end

  def new
    pj = Pj.find(params[:pj_id])
    @funcionario = pj.funcionarios.build
  end

  def edit
  end

  def create
    pj = Pj.find(params[:pj_id])
    @funcionario = pj.funcionarios.new(funcionario_params)
    
    if @funcionario.save
      redirect_to :pj_funcionarios
    else
      render :new
    end
  end

  def update
    pj = Pj.find(params[:pj_id])
    @funcionario = pj.funcionarios.find(params[:id])
    
    if @funcionario.update(funcionario_params)
      redirect_to @funcionario
    else
      render :edit
    end
  end

  def destroy
    pj = Pj.find(params[:pj_id])
    @funcionario = pj.funcionarios.find(params[:id])
    @funcionario.destroy
    
    redirect_to root_url
  end
  
  private
    def set_funcionario
        @funcionario = Funcionario.find(params[:id])
    end

    def funcionario_params
        params.require(:funcionario).permit(:cpf, :nome, :cargo, :email, :senha, :esta_ativa, :pj_id)
    end
end