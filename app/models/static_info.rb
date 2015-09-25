class StaticInfo < ActiveRecord::Base
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
    return StaticInfo.where(key: m).first
  end  

  def self.update_key(key, value)
    # if self.respond_to?(key)
      if new_obj = self.send(key)
        # new_obj = StaticInfo.new
        new_obj.update_attribute(:value,value)
      else
        params_hash = { 'key' => key, 'value' => value }
        new_obj = StaticInfo.new params_hash
        new_obj.save
      end
    # end
  end

  private

  def instagram_user_name
    return StaticInfo.user_key
  end

  def instagram_user_tags
    return StaticInfo.user_tags
  end

  def instagram_user_id
    return StaticInfo.user_id
  end

  def self.instagram_user_id
    return :user_id
  end

  def self.instagram_user_name
    return :user_name
  end

  def self.instagram_user_tags
    return :tags
  end

  def contact_params
    params.require(:contact).permit(:key, :value)
  end

end