
HireFire::Resource.configure do |config|
  config.dyno(:worker) do
  	require 'aws/sqs'
    HireFire::Macro::Sqs.queue("video_queue")
  end
end