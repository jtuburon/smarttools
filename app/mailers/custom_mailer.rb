class CustomMailer < ActionMailer::Base
  default from: "cloudcomputing.g17@gmail.com"

  def converted_video_email(v)
  	@video= v
    mail(to: @video.user_email, subject: 'Video exitosamente convertido')
  end
end