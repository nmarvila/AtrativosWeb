class VisitorsController < ApplicationController
    def login_form
        session[:page] = "login"
        render "login"
    end
    
    def login 
        if params["usuario"]["tipo"] === "pj"
            pj = Pj.where(email: params["usuario"]["email"]).first
            if pj != nil && pj.senha === params["usuario"]["senha"] && pj.esta_ativa === true
                session[:user_id] = pj.id
                session[:pj_id] = pj.id
                session[:user_type] = "pj"
                session[:page] = "home"
                flash[:success] = "Login efetuado com sucesso. Seja bem-vindo." 
                redirect_to root_url
            else
                flash[:error] = "Erro ao efetuar login. Verifique as informações passadas e tente novamente."
                session[:page] = "home"
                redirect_to root_url
            end
        else params["usuario"]["tipo"] === "funcionario"
            funcionario = Funcionario.where(email: params["usuario"]["email"]).first
            if funcionario != nil && funcionario.senha === params["usuario"]["senha"] && funcionario.esta_ativa === true
                session[:user_id] = funcionario.id
                session[:pj_id] = funcionario.pj_id
                session[:user_type] = "funcionario"
                session[:page] = "home"
                flash[:success] = "Login efetuado com sucesso. Seja bem-vindo."
                redirect_to root_url
            else
                flash[:error] = "Erro ao efetuar login. Verifique as informações passadas e tente novamente."
                session[:page] = "home"
                redirect_to root_url
            end
        end
    end
    
    def logout
        reset_session
        session[:page] = "home"
        redirect_to root_url
    end
    
    def index
        session[:page] = "home"
    end
end
