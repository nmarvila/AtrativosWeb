class AtrativosController < ApplicationController
  before_action :set_atrativo, only: [:show, :edit, :update, :destroy]
  
  def index
    pj = Pj.find(params[:pj_id])
    @atrativos = pj.atrativos
  end

  def show
  end

  def new
    pj = Pj.find(params[:pj_id])
    @atrativo = pj.atrativos.build
  end

  def edit
  end

  def create
    pj = Pj.find(params[:pj_id])
    @atrativo = pj.atrativos.new(atrativo_params)
    
    if @atrativo.save
      redirect_to :pj_atrativos
    else
      render :new
    end
  end

  def update
    if @atrativo.update(atrativo_params)
      redirect_to @atrativo
    else
      render :edit
    end
  end

  def destroy
    @atrativo.destroy
    
    redirect_to root_url
  end
  
  private
    def set_atrativo
        pj = Pj.find(params[:pj_id])
        @atrativo = pj.atrativos.find(params[:id])
    end

    def atrativo_params
        params.require(:atrativo).permit(:nome, :endereco, :duracao, :capacidade, 
        :imagem, :ingresso_crianca, :ingresso_adulto, :pj_id)
    end
end
