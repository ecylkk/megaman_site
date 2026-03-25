# config/routes.rb
Rails.application.routes.draw do
  root "pages#select"
  get "/stage/:id", to: "pages#stage", as: :stage
  post "/clear_stage", to: "pages#clear_stage"
end
