
require 'aws-sdk-s3'

ACCESS_KEY_ID = "Acess Key ID here"
SECRET_ACCESS_KEY = "Secret Access Key here"
REGION_ID = "Region here"
BUCKET_NAME = "Your bucket name here"

def uploadS3
  credentials = Aws::Credentials.new(
                                     ACCESS_KEY_ID,
                                     SECRET_ACCESS_KEY
                                     )
  s3 = Aws::S3::Client.new(
                          region: REGION_ID,
                          credentials: credentials
                          )

  file_name = 'Complete path to yoour file here'
    name = File.join('export', file_name)

      puts "start uploading #{file_name} to s3"
      a =  Time.now
      resp = s3.put_object(bucket: BUCKET_NAME, acl: "public-read", key: file_name, body: name)
      puts resp
      b =  Time.now
    puts "File should be available at https://#{BUCKET_NAME}.s3.amazonaws.com/#{file_name}"
    puts "File uploaded in #{b - a} seconds"

end

uploadS3
