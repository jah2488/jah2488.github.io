
# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end
#
helpers do
  def title
    current_page.metadata[:page]["title"]
  end
end

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'
set :markdown_engine, :kramdown

activate :syntax, line_numbers: true
activate :relative_assets

activate :blog do |b|
  b.name = 'posts'
  b.prefix = 'blog'
  b.permalink = '{title}.html'
end

activate :blog do |b|
  b.name = 'games'
  b.prefix = 'game'
  b.permalink = '{title}.html'
end

activate :blog do |b|
  b.name = 'talks'
  b.prefix = 'talk'
  b.permalink = '{title}.html'
end

page "/blog/*", layout: :article_layout
page "/blog/index.html", layout: :layout
page "/game/*", layout: :game_layout
page "/game/index.html", layout: :layout
page "/about/*", layout: :no_grid

# Build-specific configuration
configure :development do
  activate :livereload
end

configure :build do
  # activate :minify_css
  # activate :minify_javascript
  # activate :minify_html
  # activate :imageoptim
  set :relative_links, true

  activate :directory_indexes
  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
