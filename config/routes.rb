Rails.application.routes.draw do
  resources :departamentos
  get "produtos/busca", to: "produtos#busca", as: :busca_produto
  resources :produtos, only:[:new, :create,:destroy, :edit, :update]
  root to:"produtos#index" 
  get "product/check", to:"produtos#show", as: :checkout
 end
