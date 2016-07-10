class Slack
  def initialize user
    @token = user.slack_token
  end

  def channels
    method("channels.list")["channels"].map { |h| OpenStruct.new h }
  end

  def groups
    method("groups.list")["groups"].map { |h| OpenStruct.new h }
  end

  def clear_group id
    group_history(id).each do |msg|
      delete_message id, msg.ts
    end
  end

  def clear_channel id
    channel_history(id).each do |msg|
      delete_message id, msg.ts
    end
  end

  def group_history id
    method("groups.history", body: { channel: id, count: 1000 })["messages"].map { |m| OpenStruct.new m }
  end

  def channel_history id
    method("channels.history", body: { channel: id, count: 1000 })["messages"].map { |m| OpenStruct.new m }
  end

  def delete_message channel, timestamp
    Rails.logger.info "Deleting #{channel}@#{timestamp}"
    method("chat.delete", body: { channel: channel, ts: timestamp })
  end

  private

  def method m, opts={}
    opts[:body] ||= {}
    opts[:body][:token] = @token

    r = HTTParty.post "https://slack.com/api/#{m}", opts
    if r.code == 429
      raise "Hit rate limit"
    elsif r["error"]
      raise r["error"]
    end
    r
  end
end
