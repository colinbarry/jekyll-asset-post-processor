module JekyllAssetPostprocessor

    class ProcessAssetTag < Liquid::Tag
        def initialize(tag_name, args, token)
            super
            @args = args.strip
        end

        def render(context)
            site = context.registers[:site]
            page = context.registers[:page]

            stylesheet_path = @args
            if @args[0] == '@'
                site_property = @args[1..-1]
                if site_property.length <= 0
                    raise 'No variable given'
                end
                stylesheet_path = page[site_property]
            end
            
            if stylesheet_path.length == 0
                raise 'Empty stylesheet path given'
            end

            JekyllAssetPostprocessor::process(site, stylesheet_path)
        end
    end
    Liquid::Template.register_tag('process_asset', ProcessAssetTag)

end