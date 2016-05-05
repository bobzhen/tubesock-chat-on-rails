Rails.application.routes.draw do
  get '/chat' => 'chat#chat'
  root to: 'chat#index'
end
