require 'fog'
require 'open-uri'
require 'fileutils'

module VideosHelper
	def all_converted_videos_in_competition(competition)
		@videos= Video.where(["competition_id = ? and converted_at IS NOT NULL", @competition]).order('created_at DESC').paginate(:page => params[:page], :per_page => 2);
	end

	def self.convert_pending_videos  

		# Creating the connection
		connection = Fog::Storage.new({
			:provider					=>	'AWS',
			:aws_access_key_id			=>	ENV['AWS_ACCESS_KEY_ID'],
			:aws_secret_access_key		=>	ENV['AWS_SECRET_ACCESS_KEY'],
		})

		directory = connection.directories.get("smarttools-bucket")
		pending_videos = Video.where('c_video is NULL');

		pending_videos.each do |video|
			# Creating the temporal folder
			local_video_path = Rails.root.join("public", "uploads", "#{video.class.to_s.underscore}", "#{video.id}", "o_video")
			FileUtils.mkdir_p(local_video_path) unless File.exists?(local_video_path)
			# Getting the name of the file
			file_name = File.basename(video.o_video.path, ".*") + ".mp4"
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
			video.c_video = c_video
			video.converted_at = DateTime.now
			video.status = 1
			video.save()
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
				video.c_video = file.public_url
				video.save()
				# Deleting the files
				File.delete(c_filename)
				File.delete(full_path_file)
				# Sending the email
				CustomMailer.converted_video_email(video).deliver
			end
		end
	end
end
