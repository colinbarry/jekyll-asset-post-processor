module JekyllAssetPostprocessor

    class CSSAssetTag < Liquid::Tag
        def initialize(tag_name, args, token)
            super
            @args = args.strip
        end

        def render(context)
            site = context.registers[:site]
            page = context.registers[:page]

            if @args != ''
                stylesheet_property = @args
                JekyllAssetPostprocessor::process(site.source, stylesheet_property)
            elsif page.key?('stylesheet')
                stylesheet_property = page['stylesheet']
                puts stylesheet_property
                JekyllAssetPostprocessor::process(site.source, stylesheet_property)
            end

            return 'debug'
        end
    end
    Liquid::Template.register_tag('css_asset', CSSAssetTag)

end