require 'rails_helper.rb'

feature 'gerenciar Atrativo' do
  
  before(:each) do
    pj_new
  end
  
  scenario 'incluir Atrativo' do
    visit page.current_url + "/atrativos/new"
    
    preencher
    
    click_button 'Cadastrar Atrativo'
    
    expect(page).to have_content 'Parque'
  end
  
  scenario 'alterar Atrativo' do
    visit page.current_url + "/atrativos/new"
    
    preencher
    
    click_button 'Cadastrar Atrativo'
    
    click_link 'Editar'
    
    preencher_edit
    
    click_button 'Atualizar Informações'
    
    expect(page).to have_field('nome_', disabled: true, with: "Trilha")
    expect(page).to have_field('endereco_', disabled: true, with: "Rua 2")
    expect(page).to have_field('duracao_', disabled: true, with: "25")
    expect(page).to have_field('capacidade_', disabled: true, with: "60")
    expect(page).to have_field('ingresso_crianca_', disabled: true, with: "R$ 30,00")
    expect(page).to have_field('ingresso_adulto_', disabled: true, with: "R$ 60,00")
    expect(page).to have_css('img', count: 1)
  end
  
  scenario 'excluir Atrativo' do
    visit page.current_url + "/atrativos/new"
    
    preencher
    
    click_button 'Cadastrar Atrativo'
    
    click_button 'Excluir'
    
    expect(page).to_not have_content 'Parque'
  end
  
  def preencher
    fill_in "atrativo_nome", :with => "Parque"
    fill_in "atrativo_endereco", :with => "Rua 1"
    fill_in "atrativo_duracao", :with => 20
    fill_in "atrativo_capacidade", :with => 50
    fill_in "atrativo_imagem", :with => "https://t-ec.bstatic.com/images/hotel/max1024x768/114/114626108.jpg"
    fill_in "atrativo_ingresso_crianca", :with => 20
    fill_in "atrativo_ingresso_adulto", :with => 40
  end
  
  def preencher_edit
    fill_in "atrativo_nome", :with => "Trilha"
    fill_in "atrativo_endereco", :with => "Rua 2"
    fill_in "atrativo_duracao", :with => 25
    fill_in "atrativo_capacidade", :with => 60
    fill_in "atrativo_imagem", :with => "https://media-cdn.tripadvisor.com/media/photo-s/0e/92/da/4e/trilha-para-caminhada.jpg"
    fill_in "atrativo_ingresso_crianca", :with => 30
    fill_in "atrativo_ingresso_adulto", :with => 60
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