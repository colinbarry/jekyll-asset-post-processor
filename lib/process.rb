module JekyllAssetPostprocessor

    def self.hash(file_path, content)
        Digest::MD5.hexdigest(content)
    end

    def self.new_jekyll_asset(site, staging_path, output_path, filename)
        site.static_files << Jekyll::StaticFile.new(site, staging_path, output_path, filename)
    end

    def self.process(site, file_path)
        source = site.source
        path = File.join(source, file_path)
        basename = File.basename(path)
        filename = File.basename(path, '.*')
        extension = File.extname(basename)

        # generate the destination path, by default insert into assets directory
        staging_path = '_assets/staging'
        destination_path = 'assets'
        split_path = file_path.split("/")
        if split_path.length > 2
            destination_path += '/' + split_path[1..-2].join('/')
        end
        
        file_hash = nil
        new_extension = extension
        rendered = nil
        if extension == '.scss'
            new_extension = '.css'
            File.open(path, 'r') do |file|
                rendered = SassC::Engine.new(file.read, syntax: :scss, style: :compressed).render
                file_hash = hash(file_path, rendered)
            end
        else
            File.open(path, 'rb') do |file|
                file_hash = hash(file_hash, file.read)
            end
        end

        generated_filename = "#{filename}-#{file_hash}#{new_extension}"
        staging_destination = File.join(source, staging_path, destination_path)

        FileUtils.mkpath(staging_destination) unless File.directory?(staging_destination)
        generated_staging_path = File.join(staging_destination, generated_filename)
        if !rendered.nil?
            File.open(generated_staging_path, 'w') do |file|
                file.write(rendered)
            end
        else
            FileUtils.cp(path, File.join(staging_destination, generated_filename))
        end

        new_jekyll_asset(site, staging_path, destination_path, generated_filename)
        return "/" + File.join(destination_path, generated_filename)

    end

end