require "shrine"
require "shrine/storage/s3"

s3_settings = 
  case Rails.env
  when "development", "test"
    s3_settings =
      {
        access_key_id:     ENV['MINIO_ROOT_USER'],
        secret_access_key: ENV['MINIO_ROOT_PASSWORD'],
        endpoint:          ENV['MINIO_ENDPOINT'],
        region:            ENV['MINIO_REGION_NAME'],
        bucket:            nil,
        force_path_style:  true,
      }
    
      s3_settings[:bucket] = ENV['MINIO_BUCKET_FOR_DEVELOPMENT'] if Rails.env.development?
      s3_settings[:bucket] = ENV['MINIO_BUCKET_FOR_TEST'] if Rails.env.test?

      s3_settings
  when "production", "staging"
    {
      access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:            ENV['S3_REGION'],
      bucket:            ENV['S3_BUCKET'],
    }
  end

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_settings),   # temporary
  store: Shrine::Storage::S3.new(prefix: "uploads", **s3_settings), # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :derivatives
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data