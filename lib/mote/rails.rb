require "mote/rails/version"
require "rails"
require "mote"

class Mote
  module Rails
    class Engine < ::Rails::Engine
    end

    class Railtie < ::Rails::Railtie
      config.app_generators.template_engine :mote

      initializer "mote_rails.configure_template_digestor" do |app|
        ActiveSupport.on_load(:action_view) do
          ActiveSupport.on_load(:after_initialize) do
            begin
              if defined?(CacheDigests::DependencyTracker)
                # "cache_digests" gem being used (overrides Rails 4 implementation)
                CacheDigests::DependencyTracker.register_tracker(
                  :mote, CacheDigests::DependencyTracker::ERBTracker
                )

                if ::Rails.env.development?
                  # recalculate cache digest keys for each request
                  CacheDigests::TemplateDigestor.cache = ActiveSupport::Cache::NullStore.new
                end
              elsif ::Rails.version.to_s >= "4.0"
                # will only apply if Rails 4, which includes "action_view/dependency_tracker"
                require "action_view/dependency_tracker"
                ActionView::DependencyTracker.register_tracker(
                  :mote, ActionView::DependencyTracker::ERBTracker
                )
              end
            rescue
              # likely this version of Rails doesn"t support dependency tracking
            end
          end
        end
      end
    end

  end
end
