class AboutMyMachines

  attr_accessor :description

  def initialize
      @description = $redis.get('about_my_machines')
  end

  def update(data)
    $redis.set('about_my_machines',data[:description])
    @description = data[:description]
    if (data[:image].present?)
      save_new_file data[:image]
    end
    return self
  end

  def save_new_file(image)
    extension = File.extname(image.tempfile)
    new_file_name = 'mini_me'
    # File.delete(Dir.pwd + '/app/assets/images/' + get_file) if get_file && File.file?(Dir.pwd + '/app/assets/images/' + get_file) 
    FileUtils.cp(image.tempfile, Dir.pwd + '/app/assets/images/')
    puts "NEW FILE NAME"
    puts Dir.pwd+'/app/assets/images/' + new_file_name + extension
    File.rename(Dir.pwd+ '/app/assets/images/' +File.basename(image.tempfile), Dir.pwd+'/app/assets/images/' + new_file_name + extension)
    $redis.set(AboutMyMachines.redis_key, new_file_name + extension)
  end

  def get_file
    return $redis.get(AboutMyMachines.redis_key) if $redis.get(AboutMyMachines.redis_key)
    return ''
  end

  def self.redis_key
    return 'about_my_machines_image'
  end
end