class AtrativosController < ApplicationController
  before_action :set_atrativo, only: [:show, :edit, :update, :destroy]
  
  def index
    session[:atrativo_id] = nil
    if Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:atrativo_id] = nil
      session[:page] = "atrativo"
      @pj = Pj.find(params[:pj_id])
      @atrativos = @pj.atrativos
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def show
    session[:atrativo_id] = @atrativo.id
    if Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:page] = "atrativo"
      @entradas = @atrativo.entradas
      @total_visitas = 0
      @total_ingressos = 0.0
      
      @entradas.each do |e|
        if e.data.month === Time.now.month
          @total_visitas += 1
          if e.tipo === "infantil"
            @total_ingressos += @atrativo.ingresso_crianca
          elsif e.tipo === "adulto"
            @total_ingressos += @atrativo.ingresso_adulto
          end
        end
      end
      
      render "show"
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      session[:atrativo_id] = nil
      redirect_to root_url
    end
  end

  def new
    session[:atrativo_id] = nil
    if session[:user_type] === "pj" && Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:page] = "atrativo"
      @pj = Pj.find(params[:pj_id])
      @atrativo = @pj.atrativos.build
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end

  def edit
    session[:atrativo_id] = @atrativo.id
    if Integer(session[:pj_id]) === Integer(params[:pj_id])
      session[:page] = "atrativo"
      render "edit"
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      session[:atrativo_id] = nil
      redirect_to root_url
    end
  end

  def create
    @pj = Pj.find(params[:pj_id])
    @atrativo = @pj.atrativos.new(atrativo_params)
    
    if @atrativo.save
      session[:page] = "atrativo"
      redirect_to :pj_atrativos
    else
      session[:page] = "atrativo"
      render :new
    end
  end

  def update
    if @atrativo.update(atrativo_params)
      session[:page] = "atrativo"
      redirect_to pj_atrativo_url(@atrativo.pj_id, @atrativo.id)
    else
      session[:page] = "atrativo"
      render :edit
    end
  end

  def destroy
    if session[:user_type] === "pj" && Integer(session[:pj_id]) === Integer(params[:pj_id])
      @atrativo.destroy
      
      session[:page] = "atrativo"
      redirect_to :pj_atrativos
    else
      flash[:error] = "Você não possui permissão para acessar essa página."
      session[:page] = "home"
      redirect_to root_url
    end
  end
  
  private
    def set_atrativo
        @pj = Pj.find(params[:pj_id])
        @atrativo = @pj.atrativos.find(params[:id])
    end

    def atrativo_params
        params.require(:atrativo).permit(:nome, :endereco, :duracao, :capacidade, 
        :imagem, :ingresso_crianca, :ingresso_adulto, :pj_id)
    end
end
