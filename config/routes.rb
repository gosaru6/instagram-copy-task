Rails.application.routes.draw do
  root "blogs#top"
  resources :blogs do
    collection do
      get :favorite
    end
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
