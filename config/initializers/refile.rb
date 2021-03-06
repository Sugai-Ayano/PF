# Refile.backends['store'] = Refile::Backend::FileSystem.new('public/uploads/')

require 'refile/s3'
aws = {
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region: "ap-northeast-1",
  bucket: ENV['AWS_S3_BUCKET_NAME']
}
Refile.cache = Refile::S3.new(prefix: 'cache', **aws)
Refile.store = Refile::S3.new(prefix: 'store', **aws)