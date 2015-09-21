class Instagram

  attr_accessor :user
  attr_accessor :user_id
  attr_accessor :tags

  def initialize
    file_contents = ""
    File.open(file_path, "r") do |f|
      file_contents = f.read
    end
    file_split_contents = file_contents.split("\n")
    @user = get_file_value(file_split_contents.first)
    @user_id = get_file_value(file_split_contents[1])
    tags = get_file_value(file_split_contents.last)
    unless tags == nil
      @tags = tags.split(',')
    end
    return self
  end

  def save
    user_name = @user == nil ? '' : @user
    user_id = @user_id == nil ? '' : @user_id
    tags = @tags == nil ? [] : @tags
    tags = tags.join(',') unless tags.class == String
    write_string = "user_name:#{user_name}\nuser_id:#{user_id}\ntags:#{tags}" 
    File.open(file_path, "w+") do |f|
      f.write(write_string)
    end
    return self
  end

  def tags_array
    return [] unless @tags
    return @tags
  end

  private


  def file_path
    return "config/instagram_user_info.txt" if Rails.env == 'development'
    return ENV["APP_PATH"] + "/shared/config/instagram_user_info.txt"
  end

  def get_file_value(file_line)
    return nil unless file_line
    return file_line.split(":").last.strip
  end
end