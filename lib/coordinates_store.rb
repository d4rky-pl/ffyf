class CoordinatesStore
  def initialize(session)
    @session = session
  end

  def store(coordinates)
    @session[:lat] = coordinates.lat
    @session[:lng] = coordinates.lng
  end

  def fetch
    coordinates ||= Coordinates.initialize(@session[:lat], @session[:lng])
  end
end