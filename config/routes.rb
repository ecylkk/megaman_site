# config/routes.rb
Rails.application.routes.draw do
  root "pages#select"
  get "/stage/:id", to: "pages#stage", as: :stage
  post "/stage/:id/visitor_context", to: "pages#visitor_context", as: :stage_visitor_context
  post "/clear_stage", to: "pages#clear_stage"
  post "/comments", to: "comments#create", as: :comments
end
