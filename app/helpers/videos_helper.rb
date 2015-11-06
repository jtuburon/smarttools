require 'fog'
require 'open-uri'
require 'fileutils'
require 'aws/ses'
include SqsHelper

module VideosHelper
	def all_converted_videos_in_competition(competition)
		@videos= Video.where(:competition_id=> @competition.id, :status => 1)
		#@videos= Video.where(["competition_id = ? and converted_at IS NOT NULL", @competition]).order('created_at DESC').paginate(:page => params[:page], :per_page => 2);
	end

	def self.send_mail_ses(v)
		@video = v
		ses = AWS::SES::Base.new(
			:access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
			:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
		)
		ses.send_email(
			:to        => [@video.user_email],
			:source    => '"SmartTools" <cloudcomputing.g17@gmail.com>',
			:subject   => 'Video exitosamente convertido',
			:text_body => 'Tu video ha sido recibido y convertido exitosamente'
		)
	end

	def self.convert_pending_videos  
		# Creating the connection
		connection = Fog::Storage.new({
			:provider					=>	'AWS',
			:aws_access_key_id			=>	ENV['AWS_ACCESS_KEY_ID'],
			:aws_secret_access_key		=>	ENV['AWS_SECRET_ACCESS_KEY'],
		})

		directory = connection.directories.get("smarttools-bucket")
		# Get one element from the queue
		message_from_queue = obtain_message_from_queue[0]
		if message_from_queue

			# Searching the video
			video = Video.find_by_id(message_from_queue.body)
			if video
				# Creating the temporal folder
				local_video_path = Rails.root.join("public", "uploads", "#{video.class.to_s.underscore}", "#{video.id}", "o_video")
				FileUtils.mkdir_p(local_video_path) unless File.exists?(local_video_path)
				# Getting the name of the file
				
				file_name = video.o_video.filename

				# Downloading the file locally
				full_path_file = Rails.root.join(local_video_path, file_name)
				
				open(full_path_file, 'wb') do |file|
					file << open(video.o_video.url).read
				end
				# Converting the local video
				movie = FFMPEG::Movie.new(full_path_file)
				converted_filename = Rails.root.join("public", "uploads", "#{video.class.to_s.underscore}", "#{video.id}", "c_video")
				FileUtils.mkdir_p(converted_filename) unless File.exists?(converted_filename)
				c_filename= Rails.root.join("public", "uploads", "#{video.class.to_s.underscore}", "#{video.id}", "c_video", file_name)
				transcoded_movie = movie.transcode(c_filename, "-acodec aac -vcodec libx264 -profile:v high -strict -2")
				# Saving the changes
				converted_path = "/uploads/#{video.class.to_s.underscore}/#{video.id}/c_video"
				c_video = converted_path + "/" + file_name
				video.c_video = "http://d28ipe8be7lpyg.cloudfront.net#{c_video}"
				video.converted_at = DateTime.now
				video.status = 1
				video.save(:validate => false)
				print video
				# Uploading the new version
				if File.exists?(c_filename)
					#Creating the S3 directory 
					directory = connection.directories.create(
						:key		=> "smarttools-bucket#{converted_path}",
						:public		=> true
					)
					# Creating the file
					file = directory.files.create(
						:key		=> file_name,
						:body		=> File.open(c_filename),
						:public		=> true
					)
					# Deleting the files
					File.delete(c_filename)
					File.delete(full_path_file)
					# Sending the email
					#send_mail_ses(video)
					CustomMailer.converted_video_email(video).deliver
					# Deleting the queue file
					delete_message_from_queue(message_from_queue.receipt_handle)
				end
			end
		end
	end
end
