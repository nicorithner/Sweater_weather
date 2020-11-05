class BackgroundsFacade
  def self.get_image(location)
    response = ImageService.get_image('denver, co')
    Image.new(response)
  end
end