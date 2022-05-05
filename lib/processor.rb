module JekyllAssetPostProcessor

    # Subclass any processors with JekyllAssetPostProcessor::Processor.
    #
    # To register your processor:
    #     `JekyllAssetPostProcessor::register_process('.ext', processor)`
    class Processor
        # If overriding you are required to call `super`.
        def initialize(filename, extension, source_path)
            # Filename stripped of the extension.
            @filename = filename
            # Extension, containing the prefix '.'.
            @extension = extension
            # The source path directly given from {% process_asset %}
            @source_path = source_path
        end

        # Optional to override, default behavior is using the original extension.
        def new_extension
            @extension
        end

        # Process the string value of the file, useful for text based files like
        # JS and CSS.
        #
        # You are given the Liquid context as the second arguument which can
        # be used like `Liquid::Template.parse(contents).render(liquid_context)`.
        # The string contents argument given is pre-Liquid rendering, you must
        # render Liquid content yourself as shown before.
        #
        # You must override either this or `process_binary`. See also `process_binary`.
        def process(contents, liquid_context)
            nil
        end

        # Process the binary value of the file, useful for binary files like 
        # images and videos.
        #
        # You are given the Liquid context as the second argument. Rendering
        # the content may be less useful as Liquid only works with strings,
        # however you can get the page and site variables like so:
        #     page = liquid_context.registers[:page]
        #     site = liquid_context.registers[:site]
        #     page_title = site[:title]
        #
        # You must override either this or `process`. See also `process`.
        def process_binary(contents, liquid_context)
            nil
        end
    end

    # See lib/processors/scss.rb for an example of a processor.

end