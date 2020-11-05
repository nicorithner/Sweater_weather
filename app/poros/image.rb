class Image
  attr_reader :id, :type, :location, :image_url, :author, :source, :logo
  def initialize(data)
    @id = nil
    @type = data[:json][:type] 
    @location = data[:other][:location]
    @image_url = data[:json][:webformatURL]
    @author = data[:json][:user]
    @source = data[:other][:source]
    @logo = data[:other][:logo]
  end
end