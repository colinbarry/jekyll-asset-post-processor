Gem::Specification.new do |s|
    s.name        = 'jekyll-asset-post-processor'
    s.version     = '0.1.0'
    s.summary     = 'Process then suffix your Jekyll assets with cache busting version hashes'
    s.authors     = ["Darcy Supply Ltd.", "Harry Stanton"]
    s.email       = 'harry@darcysupply.com'
    s.files       = Dir['lib/**/*.rb', 'README.md', 'LICENSE', 'ACKNOWLEDGEMENTS'].to_a
    s.homepage    = 'https://github.com/darcysupply/jekyll-asset-post-processor'
    s.license     = 'MIT'

    s.add_runtime_dependency 'jekyll', '>= 3.5', '< 5.0'
    s.add_runtime_dependency 'jekyll-watch', '~> 2.0'
    s.add_runtime_dependency 'liquid', '~> 4.0'
    s.add_runtime_dependency 'sassc', '~> 2.0'
end