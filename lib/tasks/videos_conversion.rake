task :start_videos_conversion => :environment do
  puts "Conversion Thread started!!"
  scheduler = Rufus::Scheduler.new
  scheduler.every '1m', :allow_overlapping => false do
  	VideosHelper.convert_pending_videos()	
  end
  scheduler.join
end