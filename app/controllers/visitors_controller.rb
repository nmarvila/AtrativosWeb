class VisitorsController < ApplicationController
    def login_form
        render "login"
    end
    
    def login 
        if params["usuario"]["tipo"] === "pj"
            pj = Pj.where(email: params["usuario"]["email"]).first
            if pj.senha === params["usuario"]["senha"]
                session[:user_id] = pj.id
                session[:user_type] = "pj"
                redirect_to pj
            end
        elsif params["usuario"]["tipo"] === "funcionario"
            funcionario = Funcionario.where(email: params["usuario"]["email"]).first
            if funcionario.senha === params["usuario"]["senha"]
                pj = Pj.find(funcionario.pj_id)
                session[:user_id] = funcionario.id
                session[:user_type] = "funcionario"
                redirect_to pj_funcionario_path(funcionario.id, pj.id)
            end
        end
    end
end
