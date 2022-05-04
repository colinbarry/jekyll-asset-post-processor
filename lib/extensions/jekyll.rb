# This trick comes directly from jekyll-asset-pipeline. All credit and thanks to Matt Hodan and contributors.
# https://github.com/matthodan/jekyll-asset-pipeline

module JekyllSiteExtension
    def self.included(base)
        base.class_eval do
            base_cleanup = instance_method(:cleanup)
            define_method(:cleanup) do
                return_value = base_cleanup.bind(self).call
                JekyllAssetPostprocessor::clear_cache
                return_value
            end

            base_write = instance_method(:write)
            define_method(:write) do
                return_value = base_write.bind(self).call
                # remove staged assets here
                return_value
            end
        end
    end
end

module Jekyll
    class Site
        include JekyllSiteExtension
    end
end