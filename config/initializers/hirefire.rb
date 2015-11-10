require 'aws/sqs'

HireFire::Resource.configure do |config|
  config.dyno(:worker) do
    HireFire::Macro::Sqs.queue("video_queue")
  end
end