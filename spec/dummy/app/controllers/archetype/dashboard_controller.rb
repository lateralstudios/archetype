module Archetype
  class DashboardController < BaseController
    include Archetype::Dashboard
    navigable :dashboard, ->{ root_url }
  end
end
