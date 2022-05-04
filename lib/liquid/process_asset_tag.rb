module JekyllAssetPostprocessor

    class ProcessAssetTag < Liquid::Tag
        def initialize(tag_name, args, token)
            super
            @args = args.strip
        end

        def render(context)
            template = Liquid::Template.parse(@args)
            stylesheet_path = template.render(context)
            
            if stylesheet_path.length == 0
                raise 'No asset given to process'
            end

            JekyllAssetPostprocessor::process(context, stylesheet_path)
        end
    end
    Liquid::Template.register_tag('process_asset', ProcessAssetTag)

end