module JekyllAssetPostProcessor
    def self.remove_staged_assets(jekyll_config)
        staging_path = File.join(config_staging_path(jekyll_config))
        FileUtils.rm_rf(staging_path)
    end

    # Register a new asset with Jekyll from the staging directory in order
    # to be moved into the final build directory.
    def self.new_jekyll_asset(site, staging_path, output_path, filename)
        site.static_files << Jekyll::StaticFile.new(site, staging_path, output_path, filename)
    end

    def self.processors
        @processors ||= {}
    end

    def self.register_processor(extension, processor)
        processors[extension] = processor
    end

    # Process a single asset file.
    def self.process(context, file_path)
        site = context.registers[:site]
        jekyll_config = site.config

        generated_cache_hash = cache_hash(file_path)
        return cache[generated_cache_hash] if cache.key?(generated_cache_hash)

        source = site.source
        path = File.join(source, file_path)
        basename = File.basename(path)
        filename = File.basename(path, '.*')
        extension = File.extname(basename)

        # generate the destination path, by default insert into assets directory
        staging_path = config_staging_path(jekyll_config)
        destination_path = config_destination_path(jekyll_config)

        split_path = file_path.split('/')
        if split_path.length > 2
            destination_path += '/' + split_path[1..-2].join('/')
        end
        
        generated_file_hash = nil
        new_extension = extension
        rendered = nil

        rendered = nil
        rendered_binary = nil
        if processors.key?(extension)
            processor = processors[extension].new(filename, extension, file_path)
            new_extension = processor.new_extension

            new_contents = nil
            File.open(path, 'r') do |file|
                new_contents = processor.process(file.read, context)
            end
            if new_contents.nil?
                File.open(path, 'rb') do |file|
                    new_binary_contents = processor.process_binary(file.read, context)
                    if new_binary_contents.nil?
                        raise "Processor for #{extension} doesn't override process or process_binary"
                    else
                        rendered_binary = new_binary_contents
                        generated_file_hash = file_hash(file_path, rendered_binary)
                    end
                end
            else
                rendered = new_contents
                generated_file_hash = file_hash(file_path, rendered)
            end
        else
            File.open(path, 'rb') do |file|
                generated_file_hash = file_hash(file_path, file.read)
            end
        end


        generated_filename = "#{filename}-#{generated_file_hash}#{new_extension}"
        staging_destination = File.join(source, staging_path, destination_path)

        FileUtils.mkpath(staging_destination) unless File.directory?(staging_destination)
        generated_staging_path = File.join(staging_destination, generated_filename)
        if !File.file?(generated_staging_path)
            if !rendered.nil?
                File.open(generated_staging_path, 'w') do |file|
                    file.write(rendered)
                end
            elsif !rendered_binary.nil?
                File.open(generated_staging_path, 'wb') do |file|
                    file.write(rendered_binary)
                end
            else
                FileUtils.cp(path, File.join(staging_destination, generated_filename))
            end
        end
        
        new_jekyll_asset(site, staging_path, destination_path, generated_filename)

        generated_asset_site_path = '/' + File.join(destination_path, generated_filename)
        cache[cache_hash(file_path)] = generated_asset_site_path
        return generated_asset_site_path

    end

end