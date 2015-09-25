class RedisModel
  # def self.user_name
  #   @user = nil
  #   if si = StaticInfo.where(key: instagram_user_name).first
  #     @user = si.value
  #     return @user
  #   end
  # end

  # def self.user_name_full
  #   @user = StaticInfo.where(key: instagram_user_name).first
  # end

  # def self.tags
  #   @tags = nil
  #   if si = StaticInfo.where(key: instagram_user_tags).first
  #     @tags = si.value
  #     @tags = @tags.join(',') unless @tags.class == String || @tags == nil
  #     return @tags
  #   end
  # end

  # def self.tags_full
  #   @tags = StaticInfo.where(key: instagram_user_tags).first
  # end

  # def self.user_id
  #   @user_id = nil
  #   if si = StaticInfo.where(key: instagram_user_id).first
  #     @user_id = si.value
  #   end
  # end

  # def self.user_id_full
  #   @user_id = StaticInfo.where(key: instagram_user_id).first
  # end

  def self.method_missing(m, *args, &block)
    return $redis.get(m.to_s)
  end

  def self.update_value(key, value)
    $redis.set(key,value)
  end

end