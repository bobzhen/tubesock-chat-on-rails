class ChatController < ApplicationController
  include Tubesock::Hijack

  def chat
    hijack do |tubesock|
      redis_thread = Thread.new do
        Redis.new.subscribe 'chat' do |on|
          on.message do |channel, message|
            tubesock.send_data message
          end
        end
      end

      tubesock.onmessage do |m|
        Redis.new.publish 'chat', m
      end

      tubesock.onclose do
        redis_thread.kill
      end
    end
  end
end
