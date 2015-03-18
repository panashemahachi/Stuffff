Rails.application.routes.draw do

  resources :invitations

  resources :folders

  resources :assets

  devise_for :users, :controllers => { registrations: 'registrations' }

    authenticated :user do
    root to: 'info#main', as: "authenticated_root"
  end
    root to: 'info#home'

  match 'assets/get/:id' => 'assets#get', :as => 'download', via: [:get, :post]

  get '/main' => 'info#main'

  match 'more/:folder_id' => 'info#browse', :as => 'browse', via: [:get, :post]

  #subfolders
  match 'more/:folder_id/new_folder' => 'folders#new', :as => 'new_sub_folder', via: [:get, :post]

  match 'more/:folder_id/new_file' => 'assets#new', :as => 'new_sub_file', via: [:get, :post]

  match 'more/:folder_id/rename' => 'folders#edit', :as => 'rename_folder', via: [:get, :post]

  devise_scope :user do 
    match '/signup/:invitation_token'  => 'devise/registrations#new', :as => 'signup', via: [:get, :post]
  end
end
