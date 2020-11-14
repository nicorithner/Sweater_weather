class Image
  attr_reader :id, :location, :image_url, :image_collection

  def initialize(data)
    @id = nil
    @location = data[:location]
    @image_url = data[:images].sample
    @image_collection = data[:images]
  end
end
