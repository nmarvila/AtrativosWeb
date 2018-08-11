class EntradasController < ApplicationController
  before_action :set_entrada, only: [:show, :edit, :update, :destroy]
  
  def index
    pj = Pj.find(params[:pj_id])
    atrativo = pj.atrativos.find(params[:atrativo_id])
    @entradas = atrativo.entradas
  end

  def show
  end

  def new
    pj = Pj.find(params[:pj_id])
    atrativo = pj.atrativos.find(params[:atrativo_id])
    @entrada = atrativo.entradas.build
  end

  def edit
  end

  def create
    pj = Pj.find(params[:pj_id])
    atrativo = pj.atrativos.find(params[:atrativo_id])
    @entrada = atrativo.entradas.new(entrada_params)
    
    if @entrada.save
      redirect_to :pj_atrativo_entradas
    else
      render :new
    end
  end

  def update
    if @entrada.update(entrada_params)
      redirect_to @entrada
    else
      render :edit
    end
  end

  def destroy
    @entrada.destroy
    
    redirect_to root_url
  end
  
  private
    def set_entrada
        pj = Pj.find(params[:pj_id])
        atrativo = pj.atrativos.find(params[:atrativo_id])
        @entrada = atrativo.find(params[:id])
    end

    def entrada_params
        params.require(:entrada).permit(:tipo, :data, :atrativo_id)
    end
end
