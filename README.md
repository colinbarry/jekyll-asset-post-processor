# jekyll-asset-post-processor
Suffix your Jekyll assets with cache-busting version hashes

## How it works

`jekyll-asset-post-processor` takes a given asset, suffixes a version hash based on it's contents and name, and then bundles it in your website's final build. It was built for cache busting with these core concepts in mind:

- Work with all assets: CSS, JS, images, videos, etc.
- Produce a version hash that's consistent across environments and Git friendly.
- The ability to import assets within HTML and Sass files.
- Simple to setup and use, matching Jekyll's simplicity.
- No inline templates: you handle the code, the plugin handles the assets.

Used in production at [darcysupply.com](https://darcysupply.com).

## Usage

A single tag imports an asset, which in turn returns the new relative path to the bundled asset.
 `{% process_asset _assets/css/style.scss %}` = `/assets/css/style-cdb523590dafe38b9df14dde169125a4.css`

The tag can be used in any HTML or SCSS file and even supports Liquid variables, filters, and tags. An asset is only rendered and bundled once, meaning you can include an asset more than once across multiple files without conflicts.

### HTML

Because Liquid variables are supported, you can pass a page provided variable as the input asset.

```html
<link rel="stylesheet" href="{% process_asset {{ page.stylesheet }} %}">
```

### Sass / SCSS

Sass files are parsed with Liquid, rendered with `sassc`, and then minified.

Sass files inherit the static Liquid variables from the page that imported it. In cases where a file is imported more than once, the variables present will be from the first page that imported it. Therefore it's recommended not to use variables in global files that are imported more than once.

```css
.app-glyph {
    background-image: url("{% process_asset _assets/img/app-icon.png %} ")
}
```

## Setup (WIP)

1. Add the gem to Gemfile and run `bundle install`.
2. Create a `_plugins` folder in the root of your Jekyll site, create a Ruby file or your naming, and add `require "jekyll-asset-post-processor"`.

## About

![Darcy logo](https://raw.githubusercontent.com/darcysupply/jekyll-asset-post-processor/main/.github/darcy.png)

`jekyll-asset-post-processor` is maintained by Darcy. We make apps, come [check us out](https://darcysupply.com).