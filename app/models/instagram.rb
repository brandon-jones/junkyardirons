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
    @tags = get_file_value(file_split_contents.last).split(',')
    return self
  end

  def save
    write_string = "user_name:{user_name}\nuser_id:{user_id}\ntags:{tags}" 
    File.open(file_path, "w+") do |f|
      f.write(write_string.sub("{user_name}",self.user).sub("{user_id}",self.user_id).sub("{tags}",self.tags))
    end
    return self
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