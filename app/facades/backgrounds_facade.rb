class BackgroundsFacade
  def self.get_image(location)
    response = ImageService.get_image(location)
    Image.new(response)
  end
end
