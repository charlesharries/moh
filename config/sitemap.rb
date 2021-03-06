# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.mountainsofhokkaido.com"

SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                         aws_access_key_id: ENV['S3_ACCESS_KEY'],
                                         aws_secret_access_key: ENV['S3_SECRET_KEY'],
                                         fog_directory: ENV['S3_BUCKET'],
                                         fog_region: ENV['S3_REGION'])

SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['S3_BUCKET']}.s3.amazonaws.com/"
SitemapGenerator::Sitemap.sitemaps_path = 'moh-sitemap/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add hikes_path

  Hike.find_each do |hike|
    add '/hikes/' + hike.slug, lastmod: hike.updated_at
  end
end
