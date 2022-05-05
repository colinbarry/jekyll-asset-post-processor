# jekyll-asset-post-processor
Suffix your Jekyll assets with cache-busting version hashes

## How It Works

`jekyll-asset-post-processor` takes a given asset, renders/processes it, suffixes a version hash based on it's contents and name, and then bundles it in your website's final build. It was built for cache busting with these core concepts in mind:

- Work with all assets: CSS, JS, images, videos, etc.
- Produce a version hash that's consistent across environments and is Git friendly.
- The ability to import assets within HTML and Sass files.
- Simple to setup and use, matching Jekyll's simplicity.
- No inline templates: you handle the code, the plugin handles the assets.
- Fully compatible with `jekyll serve`.
- Extendable with custom processors.

Used in production at [darcysupply.com](https://darcysupply.com).

## Usage

A single tag imports an asset, which in turn returns the new relative path to the bundled asset.
 `{% process_asset _assets/css/style.scss %}` = `/assets/css/style-cdb523590dafe38b9df14dde169125a4.css`

The tag can be used in any HTML or Sass file and even supports Liquid variables, filters, and tags. An asset is only rendered and bundled once, meaning you can include an asset more than once across multiple files without conflicts.

### HTML

Because Liquid variables are supported, you can pass a page provided variable as the input asset.

```html
<link rel="stylesheet" href="{% process_asset {{ page.stylesheet }} %}">
```

### Sass / SCSS

Sass files are parsed with Liquid, rendered with `sassc`, and then minified.

Sass files inherit the static Liquid variables from the page that imported it. In cases where a file is imported more than once, the variables present will be from the first page that imported it.

```css
.app-glyph {
    background-image: url("{% process_asset _assets/img/app-icon.png %} ")
}
```

## Setup

1. Add `gem "jekyll-asset-post-processor` to your Gemfile and run `bundle install`.
2. Add `jekyll-asset-post-processor` to plugins in `_config.yml`
```yaml
plugins:
    - jekyll-asset-post-processor
```

## Config

`jekyll-asset-post-processor` can be further configured in your Jekyll `_config.yml`.

```yaml
asset-post-processor:
    - staging_path: "_staging"
    - destination_path: "assets"
```

|Name|Description|Default|
|-|-|-|
|`staging_path`|The temporary directory where bundled assets are stored before being moved to the final build. The plugin will automatically add this file to Jekyll's excluded list, you should also add it to your `.gitignore` if necessary.|`_staging`|
|`destination_path`|The root directory in the site's final build (`_site`) where the bundled assets should be stored.|`assets`|

## Custom Processors

You can write your own processor for a specified file extension, [find full documentation](https://github.com/darcysupply/jekyll-asset-post-processor/blob/main/lib/processor.rb) within the class definition. [The Sass processor](https://github.com/darcysupply/jekyll-asset-post-processor/blob/main/lib/processors/scss.rb) is a fully working, in-production example.

## Acknowledgements

Parts of the Jekyll code and architectural choices come from [jekyll-asset-pipeline](https://github.com/matthodan/jekyll-asset-pipeline), thanks to Matt Hodan and other contributors of the project.

## About

![Darcy logo](https://raw.githubusercontent.com/darcysupply/jekyll-asset-post-processor/main/.github/darcy.png)

`jekyll-asset-post-processor` is maintained by Darcy. We make apps, come [check us out](https://darcysupply.com).