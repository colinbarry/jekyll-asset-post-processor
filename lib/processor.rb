module JekyllAssetPostProcessor

    class Processor
        def initialize(filename, extension, source_path)
            @filename = filename
            @extension = extension
            @source_path = source_path
        end

        def new_extension
            @extension
        end

        def process(contents, liquid_context)
            nil
        end

        def process_binary(contents, liquid_context)
            nil
        end
    end

end