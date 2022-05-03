module JekyllAssetPostprocessor

    def self.process(source, file)
        path = File.join(source, file)
        basename = File.basename(path)
        File.open(path) do |file|
            extension = File.extname(basename)
            if extension == '.scss'
                puts SassC::Engine.new(file.read, syntax: :scss, style: :compressed).render
            end
        end
    end

end