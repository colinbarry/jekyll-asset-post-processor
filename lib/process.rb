module JekyllAssetPostprocessor

    def self.hash(file_path, content)
        Digest::MD5.hexdigest(file_path + content)
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

        File.open(path) do |file|
            rendered = ''
            if extension == '.scss'
                rendered = SassC::Engine.new(file.read, syntax: :scss, style: :compressed).render
            else
                rendered = file.read
            end

            file_hash = hash(file_path, file.read)

            generated_filename = "#{filename}-#{file_hash}.css"
            staging_destination = File.join(source, staging_path, destination_path)

            FileUtils.mkpath(staging_destination) unless File.directory?(staging_destination)
            File.open(File.join(staging_destination, generated_filename), 'w') do |file|
                file.write(rendered)
                new_jekyll_asset(site, staging_path, destination_path, generated_filename)
            end
        end
    end

end