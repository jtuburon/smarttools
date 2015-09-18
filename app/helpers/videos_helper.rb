module VideosHelper
	def all_converted_videos_in_competition(competition)
		#@videos= Video.where(["competition_id = ? and converted_at IS NOT NULL", @competition]).order('created_at DESC').paginate(:page => params[:page], :per_page => 2);
		@videos= Video.where(competition: competition).order('created_at DESC').paginate(:page => params[:page], :per_page => 2)
	end

	def self.convert_pending_videos
		pending_videos = Video.where('c_video is NULL');
		pending_videos.each do |video|
			movie = FFMPEG::Movie.new(video.o_video.path)			
			v = VideoUploader.new(video)
			folder= File.dirname(video.o_video.path)
			b_name= File.basename(video.o_video.path, ".*") + ".mp4"
			c_folder= Rails.root.join("public", "uploads", "#{video.class.to_s.underscore}", "#{video.id}", "c_video")
			Dir.mkdir(c_folder) unless File.exists?(c_folder)
			c_filename= Rails.root.join("public", "uploads", "#{video.class.to_s.underscore}", "#{video.id}", "c_video", b_name)
			movie.transcode(c_filename, "-acodec aac -vcodec libx264 -strict -2")
			c_video= "/uploads/#{video.class.to_s.underscore}/#{video.id}/c_video/" +b_name
			video.c_video = c_video
			video.converted_at = DateTime.now
			video.save()
		end
	end
end
