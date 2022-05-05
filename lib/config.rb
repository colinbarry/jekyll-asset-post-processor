module JekyllAssetPostProcessor
    DEFAULTS = {
        'staging_path' => '_staging',
        'destination_path' => 'assets'
    }

    def self.config_staging_path(jekyll_config)
        config = jekyll_config['asset-post-processor'] || [{}]
        return config[0]['staging_path'] || DEFAULTS['staging_path']
    end

    def self.config_destination_path(jekyll_config)
        config = jekyll_config['asset-post-processor'] || [{}]
        config[0]['destination_path'] || DEFAULTS['destination_path']
    end
end