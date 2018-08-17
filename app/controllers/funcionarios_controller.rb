class FuncionariosController < ApplicationController
  before_action :set_funcionario, only: [:show, :edit, :update, :destroy]
  
  def index
    if session[:user_type] === "pj"
      session[:atrativo_id] = nil
      session[:page] = "funcionario"
      @pj = Pj.find(params[:pj_id])
      @funcionarios = @pj.funcionarios
    elsif session[:user_type] === "funcionario"
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def show
    if session[:user_type] != "pj" && session[:user_id] != @funcionario.id
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    else
      session[:page] = "funcionario"
      render "show"
    end
  end

  def new
    if session[:user_type] === "pj"
      @pj = Pj.find(params[:pj_id])
      @funcionario = @pj.funcionarios.build
      session[:page] = "funcionario"
    elsif session[:user_type] === "funcionario"
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def edit
    if session[:user_type] != "pj" && session[:user_id] != @funcionario.id
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    else
      session[:page] = "funcionario"
      render "edit"
    end
  end

  def create
    @pj = Pj.find(params[:pj_id])
    @funcionario = @pj.funcionarios.new(funcionario_params)
    
    if @funcionario.save
      session[:page] = "funcionario"
      redirect_to :pj_funcionarios
    else
      render :new
    end
  end

  def update
    if @funcionario.update(funcionario_params)
      session[:page] = "funcionario"
      redirect_to pj_funcionarios_url(@funcionario.pj_id)
    else
      render :edit
    end
  end

  def destroy
    if @funcionario.esta_ativa
      @funcionario.esta_ativa = false
      
      @funcionario.update(params.permit(:cpf, :nome, :cargo, :email, :senha, :esta_ativa, :pj_id))
      session[:page] = "funcionario"
      redirect_to :pj_funcionarios
    else
      @funcionario.esta_ativa = true
      
      @funcionario.update(params.permit(:cpf, :nome, :cargo, :email, :senha, :esta_ativa, :pj_id))
      session[:page] = "funcionario"
      redirect_to :pj_funcionarios
    end
  end
  
  private
    def set_funcionario
        @pj = Pj.find(params[:pj_id])
        @funcionario = @pj.funcionarios.find(params[:id])
    end

    def funcionario_params
        params.require(:funcionario).permit(:cpf, :nome, :cargo, :email, :senha, :esta_ativa, :pj_id)
    end
end
