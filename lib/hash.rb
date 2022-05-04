module JekyllAssetPostprocessor
    # Generate a hash to be used in the internal cache to avoid processing
    # a file more than once per build.
    def self.cache_hash(file_path)
        mtime = File.mtime(File.join(file_path))
        Digest::MD5.hexdigest(file_path + mtime.to_s)
    end

    # Generate a hash to be used in the final file name. Generated from
    # the final rendered file contents.
    def self.file_hash(file_path, content)
        Digest::MD5.hexdigest(content)
    end
end