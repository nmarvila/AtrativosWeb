require 'rails_helper.rb'

feature 'gerenciar PJ' do
  
  scenario 'incluir PJ' do
    visit new_pj_path
    verificar_new_pj
  end
  
  scenario 'alterar PJ' do
    pj = FactoryBot.create(:pj)
    verificar_edit_pj(pj)
  end
  
  scenario 'alterar PJ' do
    pj = FactoryBot.create(:pj)
    verificar_destroy_pj(pj)
  end
  
  def verificar_new_pj
    preencher

    click_button 'Cadastrar-se'

    expect(page).to have_content 'Efetue o login em sua conta'
  end
  
  def verificar_edit_pj(pj)
    visit new_pj_path
    
    preencher
    
    click_button 'Cadastrar-se'
    
    fill_in :usuario_email, :with => "empresax@empresax.com"
    fill_in :usuario_senha, :with => "123456"

    click_button 'Login'
    
    visit pjs_path
    
    visit page.current_url + "/edit"
    
    preencher_edit
    
    click_button 'Atualizar Cadastro'
    
    expect(page).to have_field('cnpj_', disabled: true, with: "23456789012345")
    expect(page).to have_field('razao_social_', disabled: true, with: "Empresa Z")
    expect(page).to have_field('nome_fantasia_', disabled: true, with: "Empresa Z")
    expect(page).to have_field('email_', disabled: true, with: "empresaz@empresaz.com")
  end
  
  def verificar_destroy_pj(pj)
    visit new_pj_path
    
    preencher
    
    click_button 'Cadastrar-se'
    
    fill_in :usuario_email, :with => "empresax@empresax.com"
    fill_in :usuario_senha, :with => "123456"

    click_button 'Login'
    
    visit pjs_path
    
    click_button 'Desativar'
    
    expect(page).to have_content 'Seja bem-vindo ao sistema Atrativos WEB!'
  end
  
  def preencher
    fill_in "pj_cnpj", :with => "12345678901234"
    fill_in "pj_razao_social", :with => "Empresa X"
    fill_in "pj_nome_fantasia", :with => "Empresa X"
    fill_in "pj_email", :with => "empresax@empresax.com"
    fill_in "pj_senha", :with => "123456"
  end
  
  def preencher_edit
    fill_in "pj_cnpj", :with => "23456789012345"
    fill_in "pj_razao_social", :with => "Empresa Z"
    fill_in "pj_nome_fantasia", :with => "Empresa Z"
    fill_in "pj_email", :with => "empresaz@empresaz.com"
    fill_in "pj_senha", :with => "234567"
  end
end