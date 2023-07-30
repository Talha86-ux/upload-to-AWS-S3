require 'aws-sdk-s3'  # v2: require 'aws-sdk'

ACCESS_KEY_ID = ""
SECRET_ACCESS_KEY = ""
AWS_REGION = ""
BUCKET_NAME = ""


def multipart_upload_s3
    credentials = Aws::Credentials.new(
        ACCESS_KEY_ID,
        SECRET_ACCESS_KEY
        )

  s3 = Aws::S3::Client.new(
                          region: AWS_REGION,
                          credentials: credentials
                          )

        filename = "Complete path to your file here"
        name = File.join('export', filename)
        object = Aws::S3::Object.new( bucket_name: BUCKET_NAME ,key: filename )
        min_chunk_size = 5 * 1024 * 1024  # S3 minimum chunk size (5Mb)
        s3.create_multipart_upload(object) do |upload|
        io = File.open(filename)
        parts = []

            bufsize = (io.size > 2 * min_chunk_size) ? min_chunk_size : io.size
            while buf = io.read(bufsize)

                part = upload.add_part(buf)
                parts << part

                if (io.size - (io.pos + bufsize)) < bufsize
                bufsize = (io.size - io.pos) if (io.size - io.pos) > 0
                end
            end
            a = Time.now
            s3.put_object(parts)
            b = Time.now
            puts "#{b - a} seconds took to upload the file"
        end
        puts "File should be available at https://#{BUCKET_NAME}.s3.amazonaws.com/#{filename}"
end

multipart_upload_s3

