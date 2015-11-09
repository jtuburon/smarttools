task :convert_video => :environment do
  VideosHelper.convert_pending_videos()	
  puts "done."
end