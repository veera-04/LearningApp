Rails.application.routes.draw do
  use_doorkeeper
  namespace :api do
    namespace :v1 do

      namespace :user_management do
        namespace :user do
          post 'auth/signup'
          post 'auth/login'
          get 'data/boards', to: 'data#boards'
          put 'data/board'
          get 'data/classes/:id', to: 'data#classes'
          put 'data/board_class'
        end
      end 
      
      namespace :content_management do
        get 'learn/subjects/:id', to: 'learn#subjects'
        get 'learn/chapters/:id', to: 'learn#chapters'
        get 'learn/contents/:id', to: 'learn#contents'
        get 'practice/exercises/:id', to: 'practice#exercises'
        get 'practice/questions/:id', to:'practice#questions'
        post 'practice/start'
        post 'practice/submit'
        get 'practice/finish/:id', to:'practice#finish'
      end
      
    end
  end
end
