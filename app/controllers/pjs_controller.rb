class PjsController < ApplicationController
  before_action :set_pj, only: [:show, :edit, :update, :destroy, :delete]
  
  def index
    if session[:user_type] === "pj"
      @pj = Pj.find(session[:user_id])
      session[:page] = ""
      redirect_to @pj
    elsif session[:user_type] === "funcionario"
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end
  
  def show
    if session[:user_type] === "funcionario"
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    else
      render "show"
    end
  end

  def new
    if session[:user_type] === "funcionario"
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    else
      @pj = Pj.new
    end
  end

  def edit
    if session[:user_type] === "funcionario"
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    else
      render "edit"
    end
  end

  def create
    @pj = Pj.new(pj_params)
    
    if @pj.save
      redirect_to "/login"
    else
      flash[:error] = "Ocorreu um erro na tentativa de cadastro. Por favor, tente novamente."
      render :new
    end
  end

  def update
    if @pj.update(pj_params)
      session[:page] = ""
      redirect_to @pj
    else
      flash[:error] = "Ocorreu um erro na tentativa de atualização. Por favor, tente novamente."
      render :edit
    end
  end

  def destroy
    if @pj.esta_ativa
      @pj.esta_ativa = false
      
      @pj.update(params.permit(:cpf, :nome, :cargo, :email, :senha, :esta_ativa, :pj_id))
      redirect_to "/logout"
    end
  end
  
  private
    def set_pj
        @pj = Pj.find(params[:id])
    end

    def pj_params
        params.require(:pj).permit(:cnpj, :razao_social, :nome_fantasia, :email, :senha, :esta_ativa)
    end
end
