class Machine < ActiveRecord::Base
  belongs_to :machine_sets
  has_many :images

  def self.save_all(machines)
    return_value = true
    machines.each do |machine|

      new_machine = Machine.new
      new_machine.title = machine['title']
      new_machine.description = machine['description']
      new_machine.machine_set_id = machine['machine_set_id']
      if new_machine.title.length > 0 && new_machine.save

        machine['images'].each do |image|
          uploaded_file = Cloudinary::Uploader.upload(image.tempfile.path)
          new_image = Image.new
          new_image.public_id = uploaded_file['public_id']
          new_image.width = uploaded_file['width']
          new_image.height = uploaded_file['height']
          new_image.format = uploaded_file['format']
          new_image.bytes = uploaded_file['bytes']
          new_image.url = uploaded_file['url']
          new_image.secure_url = uploaded_file['secure_url']

          new_image.machine_id = new_machine.id

          if !new_image.save
            return false
          end
        end

      end

      return return_value

    end
  end
end
