Rails.application.routes.draw do
  Archetype.mount(self, path: '/admin') do
    root to: 'dashboard#show'
  end
end
