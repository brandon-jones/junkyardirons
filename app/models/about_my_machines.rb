class AboutMyMachines

  attr_accessor :description

  def initialize
      @description = $redis.get('about_my_machines')
  end

  def update(data)
    $redis.set('about_my_machines',data[:description])
    @description = data[:description]
    return self
  end
end