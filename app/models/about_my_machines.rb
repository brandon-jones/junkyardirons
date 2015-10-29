class AboutMyMachines
  # has_many :pictures, as: :imageable

  attr_accessor :description, :image

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
    uploaded_file = Cloudinary::Uploader.upload(image.tempfile.path, :public_id => 'about_my_machine')
    $redis.set(AboutMyMachines.redis_key, uploaded_file['url'])
  end

  def get_image_url
    return $redis.get(AboutMyMachines.redis_key) if $redis.get(AboutMyMachines.redis_key)
    return ''
  end

  def self.redis_key
    return 'about_my_machines_image'
  end
end