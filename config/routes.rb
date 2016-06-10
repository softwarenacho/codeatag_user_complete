Rails.application.routes.draw do
  resources :proposals
  root 'proposals#index'
  match '/twitter_search', to: 'twitter#search_users', via: 'get', as: 'twitter_search'
  match '/add_proposal', to: 'twitter#add_proposal', via: 'post', as: 'add_proposal'
  match '/twitter_proposal', to: 'twitter#twitter_proposal',     via: 'get'
end
