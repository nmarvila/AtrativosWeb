require 'rails_helper.rb'

feature 'gerenciar Atrativo' do
  
  before(:each) do
    pj_e_atrativo_new
  end
  
  scenario 'incluir Entrada' do
    visit page.current_url + "/entradas/new"
    
    preencher
    
    click_button 'Cadastrar Entrada'
    
    expect(page).to have_content 'Adulto'
    expect(page).to have_content '21/08/2018'
  end
  
  scenario 'alterar Entrada' do
    visit page.current_url + "/entradas/new"
    
    preencher
    
    click_button 'Cadastrar Entrada'
    
    click_link 'Editar'
    
    preencher_edit
    
    click_button 'Atualizar Informações'
    
    expect(page).to have_content("Infantil")
    expect(page).to have_content("20/08/2018")
  end
  
  scenario 'excluir Entrada' do
    visit page.current_url + "/entradas/new"
    
    preencher
    
    click_button 'Cadastrar Entrada'
    
    click_button 'Excluir'
    
    expect(page).to_not have_content 'Adulto'
  end
  
  def preencher
    select "Adulto", :from => "entrada_tipo"
    fill_in "entrada_data", :with => "2018-08-21"
  end
  
  def preencher_edit
    select "Infantil", :from => "entrada_tipo"
    fill_in "entrada_data", :with => "2018-08-20"
  end
  
  def pj_e_atrativo_new
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
    
    visit page.current_url + "/atrativos/new"
    
    fill_in "atrativo_nome", :with => "Parque"
    fill_in "atrativo_endereco", :with => "Rua 1"
    fill_in "atrativo_duracao", :with => 20
    fill_in "atrativo_capacidade", :with => 50
    fill_in "atrativo_imagem", :with => "https://t-ec.bstatic.com/images/hotel/max1024x768/114/114626108.jpg"
    fill_in "atrativo_ingresso_crianca", :with => 20
    fill_in "atrativo_ingresso_adulto", :with => 40
    
    click_button 'Cadastrar Atrativo'
    
    click_link 'Visualizar'
  end
end