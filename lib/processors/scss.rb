# See lib/processor.rb for full documentation.

module JekyllAssetPostProcessor
    
    class SassProcessor < JekyllAssetPostProcessor::Processor

        def new_extension
            '.css'
        end

        def process(contents, liquid_context)
            sass = SassC::Engine.new(contents, syntax: :scss, style: :compressed).render
            Liquid::Template.parse(sass).render(liquid_context)
        end

    end
    JekyllAssetPostProcessor::register_processor('.scss', SassProcessor)

end