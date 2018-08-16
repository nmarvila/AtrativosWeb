class EntradasController < ApplicationController
  before_action :set_entrada, only: [:show, :edit, :update, :destroy]
  
  def index
    if Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:page] = "entrada"
      @pj = Pj.find(params[:pj_id])
      @atrativo = @pj.atrativos.find(params[:atrativo_id])
      @entradas = @atrativo.entradas
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:atrativo_id] = nil
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def show
    if Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:page] = "entrada"
      render "show"
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:atrativo_id] = nil
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def new
    if Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:page] = "entrada"
      @pj = Pj.find(params[:pj_id])
      @atrativo = @pj.atrativos.find(params[:atrativo_id])
      @entrada = @atrativo.entradas.build
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:atrativo_id] = nil
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def edit
    if Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:page] = "entrada"
      render "edit"
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:atrativo_id] = nil
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def create
    @pj = Pj.find(params[:pj_id])
    @atrativo = @pj.atrativos.find(params[:atrativo_id])
    @entrada = @atrativo.entradas.new(entrada_params)
    
    if @entrada.save
      redirect_to :pj_atrativo_entradas
    else
      render :new
    end
  end

  def update
    if @entrada.update(entrada_params)
      redirect_to pj_atrativo_entradas_url(@pj.id, @entrada.atrativo_id)
    else
      render :edit
    end
  end

  def destroy
    @entrada.destroy
    
    redirect_to :pj_atrativo_entradas
  end
  
  private
    def set_entrada
        @pj = Pj.find(params[:pj_id])
        @atrativo = @pj.atrativos.find(params[:atrativo_id])
        @entrada = @atrativo.entradas.find(params[:id])
    end

    def entrada_params
        params.require(:entrada).permit(:tipo, :data, :atrativo_id)
    end
end
