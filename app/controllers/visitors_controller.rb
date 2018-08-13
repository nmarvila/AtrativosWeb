class VisitorsController < ApplicationController
    def login_form
        render "login"
    end
    
    def login 
        if params["usuario"]["tipo"] === "pj"
            pj = Pj.where(email: params["usuario"]["email"]).first
            if pj != nil && pj.senha === params["usuario"]["senha"]
                session[:user_id] = pj.id
                session[:user_type] = "pj"
                flash[:success] = "Login efetuado com sucesso. Seja bem-vindo." 
                redirect_to root_url
            else
                flash[:error] = "Erro ao efetuar login. Verifique as informações passadas e tente novamente."
                redirect_to root_url
            end
        elsif params["usuario"]["tipo"] === "funcionario"
            funcionario = Funcionario.where(email: params["usuario"]["email"]).first
            if funcionario != nil && funcionario.senha === params["usuario"]["senha"]
                pj = Pj.find(funcionario.pj_id)
                session[:user_id] = funcionario.id
                session[:user_type] = "funcionario"
                flash[:success] = "Login efetuado com sucesso. Seja bem-vindo."
                redirect_to root_url
            else
                flash[:error] = "Erro ao efetuar login. Verifique as informações passadas e tente novamente."
                redirect_to root_url
            end
        end
    end
    
    def logout
        reset_session
        redirect_to root_url
    end
end
