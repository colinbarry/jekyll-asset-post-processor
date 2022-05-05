# See lib/processor.rb for full documentation.

module JekyllAssetPostProcessor
    
    class SassProcessor < JekyllAssetPostProcessor::Processor

        def new_extension
            '.css'
        end

        def process(contents, liquid_context)
            template = Liquid::Template.parse(contents)
            SassC::Engine.new(template.render(liquid_context), syntax: :scss, style: :compressed).render
        end

    end
    JekyllAssetPostProcessor::register_processor('.scss', SassProcessor)

end