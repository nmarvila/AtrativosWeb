require 'rails_helper.rb'

feature 'gerenciar Funcionário' do
  
  before(:each) do
    pj_new
  end
  
  scenario 'incluir Funcionário' do
    visit page.current_url + "/funcionarios/new"
    
    preencher
    
    click_button 'Cadastrar Funcionário'
    
    expect(page).to have_content '12345678901'
    expect(page).to have_content 'João Silva'
    expect(page).to have_content 'Desenvolvedor'
    expect(page).to have_content 'joao@empresax.com'
    expect(page).to have_content 'Ativo'
  end
  
  scenario 'alterar Funcionário' do
    visit page.current_url + "/funcionarios/new"
    
    preencher
    
    click_button 'Cadastrar Funcionário'
    
    click_link 'Editar'
    
    preencher_edit
    
    click_button 'Atualizar Informações'
    
    expect(page).to have_field('cpf_', disabled: true, with: "23456789012")
    expect(page).to have_field('nome_', disabled: true, with: "João Silva Souza")
    expect(page).to have_field('cargo_', disabled: true, with: "Analista")
    expect(page).to have_field('email_', disabled: true, with: "joao@empresaz.com")
    expect(page).to have_field('status_', disabled: true, with: "Ativo")
    expect(page).to have_field('pj_', disabled: true, with: "Empresa X")
  end
  
  scenario 'excluir Funcionário' do
    visit page.current_url + "/funcionarios/new"
    
    preencher
    
    click_button 'Cadastrar Funcionário'
    
    click_button 'Desativar'
    
    expect(page).to have_content 'Inativo'
    expect(page).to have_content 'Reativar'
  end
  
  def preencher
    fill_in "funcionario_cpf", :with => "12345678901"
    fill_in "funcionario_nome", :with => "João Silva"
    fill_in "funcionario_cargo", :with => "Desenvolvedor"
    fill_in "funcionario_email", :with => "joao@empresax.com"
    fill_in "funcionario_senha", :with => "123456"
  end
  
  def preencher_edit
    fill_in "funcionario_cpf", :with => "23456789012"
    fill_in "funcionario_nome", :with => "João Silva Souza"
    fill_in "funcionario_cargo", :with => "Analista"
    fill_in "funcionario_email", :with => "joao@empresaz.com"
    fill_in "funcionario_senha", :with => "234567"
  end
  
  def pj_new
    visit new_pj_path
    
    fill_in "pj_cnpj", :with => "12345678901234"
    fill_in "pj_razao_social", :with => "Empresa X"
    fill_in "pj_nome_fantasia", :with => "Empresa X"
    fill_in "pj_email", :with => "empresax@empresax.com"
    fill_in "pj_senha", :with => "123456"
    
    click_button 'Cadastrar-se'
    
    fill_in :usuario_email, :with => "empresax@empresax.com"
    fill_in :usuario_senha, :with => "123456"
    
    click_button 'Login'
    
    visit pjs_path
  end
end