I4pc::Application.routes.draw do
  root to: 'feed#index', as: 'feed'

  get 'popular' => 'popular#index'

  controller :auth do
    get 'login'  => :login
    get 'logout' => :logout
    get 'auth'   => :auth
  end

  controller :like do
    get 'like/:id'   => :like,   as: 'like'
    get 'unlike/:id' => :unlike, as: 'unlike'
  end

  get 'photo/:id' => 'photo#show', as: 'photo'

  post 'comment/:id' => 'comment#post', as: 'comment'

  get 'user/:username' => 'user#show', as: 'user'

  get 'about' => 'about#show', as: 'about'

  get 'liked' => 'liked#index', as: 'liked'

  controller :follow do
    get 'follow/:id'   => :follow,   as: 'follow'
    get 'unfollow/:id' => :unfollow, as: 'unfollow'
  end

  get 'tag/:tagname' => 'tag#index'

end
