# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#

# Check this out if your're getting "/usr/bin/env: ruby: No such file or directory", https://gist.github.com/cre-o/4535005
# 1. Copy the output, echo $PATH
# 2. Pasteit here adding a new line, env :PATH, '....'
# 3. Execute this command to update the cron file, bundle exec whenever -s "environment=production" --update

set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
set :environment, :development
every 1.minute do
	runner "VideosHelper.convert_pending_videos"
end
