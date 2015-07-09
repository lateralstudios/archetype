module Archetype
  class Configuration
    attr_accessor :site_name, :user_method, :authenticate_method
    attr_accessor :javascripts
    
    def initialize
      @site_name = 'Archetype Admin'
      @user_method = :current_admin
      @authenticate_method = :authenticate_admin!

      # TODO: This is incomplete, and is interface specific
      @javascripts = %w(archetype/application)
    end
  end
end
