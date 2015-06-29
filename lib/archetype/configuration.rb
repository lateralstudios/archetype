module Archetype
  class Configuration
    attr_accessor :site_name, :user_method, :authenticate_method
    
    def initialize
      @site_name = 'Archetype Admin'
      @user_method = :current_admin
      @authenticate_method = :authenticate_admin!
    end
  end
end
