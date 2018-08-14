class PjsController < ApplicationController
  before_action :set_pj, only: [:show, :edit, :update, :destroy]
  
  def index
    if session[:user_type] === "pj"
      pj = Pj.find(session[:user_id])
      session[:page] = ""
      redirect_to pj
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end
  
  def show
  end

  def new
    @pj = Pj.new
  end

  def edit
  end

  def create
    @pj = Pj.new(pj_params)
    
    if @pj.save
      redirect_to "/login"
    else
      render :new
    end
  end

  def update
    if @pj.update(pj_params)
      session[:page] = ""
      redirect_to @pj
    else
      render :edit
    end
  end

  def destroy
    @pj.destroy
    redirect_to root_url
  end
  
  private
    def set_pj
        @pj = Pj.find(params[:id])
    end

    def pj_params
        params.require(:pj).permit(:cnpj, :razao_social, :nome_fantasia, :email, :senha, :esta_ativa)
    end
end
