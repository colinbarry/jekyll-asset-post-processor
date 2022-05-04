module JekyllAssetPostprocessor
    DEFAULTS = {
        'staging_path' => '_assets/staging',
        'destination_path' => 'assets'
    }

    def self.config_staging_path(jekyll_config)
        config = jekyll_config['asset-post-processor'] || {}
        config['staging_path'] || DEFAULTS['staging_path']
    end

    def self.config_destination_path(jekyll_config)
        config = jekyll_config['asset-post-processor'] || {}
        config['destination_path'] || DEFAULTS['destination_path']
    end
end