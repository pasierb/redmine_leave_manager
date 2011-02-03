ActionController::Routing::Routes.draw do |map|
  map.resources :leaves, :collection => { :plan => :get }
end
