require 'aws-sdk'

module SqsHelper
	def send_msg_to_queue(message)
		client = Aws::SQS::Client.new(region: 'us-east-1')
		resp = client.send_message({
			queue_url: ENV['queue_url'],
			message_body: message,
		})
	end
	def obtain_message_from_queue
		client = Aws::SQS::Client.new(region: 'us-east-1')
		resp = client.receive_message({
			queue_url: ENV['queue_url'],
			max_number_of_messages: 1,
		})
		return resp.messages
	end
	def delete_message_from_queue(receipt_handle)
		client = Aws::SQS::Client.new(region: 'us-east-1')
		resp = client.delete_message({
			queue_url: ENV['queue_url'],
			receipt_handle: receipt_handle,
		})
	end	
end