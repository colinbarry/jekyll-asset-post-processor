# This trick comes directly from jekyll-asset-pipeline. All credit and thanks to Matt Hodan and contributors.
# https://github.com/matthodan/jekyll-asset-pipeline
module JekyllSiteExtension
    def self.included(base)
        base.class_eval do
            base_cleanup = instance_method(:cleanup)
            define_method(:cleanup) do
                return_value = base_cleanup.bind(self).call
                JekyllAssetPostProcessor::clear_cache
                return_value
            end

            # No longer removing staged assets as re-generating un-changed staged assets
            # causes infinite loops when serving.
            
            # base_write = instance_method(:write)
            # define_method(:write) do
            #     return_value = base_write.bind(self).call
            #     JekyllAssetPostProcessor::remove_staged_assets(self.config)
            #     return_value
            # end
        end
    end
end

module Jekyll
    class Site
        include JekyllSiteExtension
    end
end

# Add the staging directory to the serve based 
require 'jekyll-watch'
module Jekyll
    module Watcher
        alias_method :old_custom_excludes, :custom_excludes
        def custom_excludes(options)
            options['exclude'] << JekyllAssetPostProcessor::config_staging_path(options)
            old_custom_excludes(options)
        end
    end
end