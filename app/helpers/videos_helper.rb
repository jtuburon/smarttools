module VideosHelper
	def all_converted_videos_in_competition(competition)
		#@videos= Video.where(["competition_id = ? and converted_at IS NOT NULL", @competition]).order('created_at DESC');
		@videos= Video.where(competition: competition).order('created_at DESC')
	end
end
