module Archetype
  module Interface
    class Builder
      include Archetype::ModuleBuilder

      builds :crumbs, with: HashBuilder
      builds :navigation, with: Navigable::Builder

      class << self
        def navigable(name, *args)
          opts = args.extract_options!
          opts.merge!(name: name, path: args.first)
          builders[:navigation].from_hash(opts)
        end 

        def crumb(name, *args)
          name = name.to_sym
          opts = args.extract_options!
          opts.merge!(name: name, path: args.first)
          builder = builders[:crumbs][name] || Crumb::Builder.new
          builder.from_hash(opts)
          builders[:crumbs][name] = builder
        end
      end

      def build_crumbs
        super do |crumbs|
          crumbs.each do |name, crumb|
            insert_crumb(crumb)
          end
        end
      end

      private

      def insert_crumb(crumb)
        if index = crumb.options[:position]
          configuration.crumbs.insert(index, crumb)
        else
          configuration.crumbs << crumb
        end
      end

      def configuration
        @configuration ||= Interface::Configuration.new
      end
    end
  end
end
