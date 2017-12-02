Rails.application.routes.draw do

  delete 'api/destroy'

  resources :rooms, param: :code, defaults: { format: 'json' } do
    resources :players, param: :identity, defaults: { format: 'json' }
  end

end
