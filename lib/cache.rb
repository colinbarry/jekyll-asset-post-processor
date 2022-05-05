module JekyllAssetPostProcessor
    # Return the cache and create it if not present.
    def self.cache
        @cache ||= {}
    end

    # Clear the cache.
    def self.clear_cache
        @cache = {}
    end
end