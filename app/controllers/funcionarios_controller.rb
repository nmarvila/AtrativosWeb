class FuncionariosController < ApplicationController
  before_action :set_funcionario, only: [:show, :edit, :update, :destroy]
  
  def index
    if session[:user_type] === "pj" && Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:atrativo_id] = nil
      session[:page] = "funcionario"
      @pj = Pj.find(params[:pj_id])
      @funcionarios = @pj.funcionarios
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def show
    if (session[:user_type] === "pj" && Integer(session[:pj_id]) === Integer(params[:pj_id])) || session[:user_id] === @funcionario.id
      session[:page] = "funcionario"
      render "show"
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def new
    if session[:user_type] === "pj" && Integer(session[:pj_id]) === Integer(params[:pj_id])
      @pj = Pj.find(params[:pj_id])
      @funcionario = @pj.funcionarios.build
      session[:page] = "funcionario"
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def edit
    if (session[:user_type] === "pj" && Integer(session[:pj_id]) === Integer(params[:pj_id])) || session[:user_id] === @funcionario.id
      session[:page] = "funcionario"
      render "edit"
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
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
      redirect_to pj_funcionario_url(@funcionario.pj_id, @funcionario.id)
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
