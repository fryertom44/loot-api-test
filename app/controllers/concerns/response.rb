module Response
  def json_response(object, status = :ok)
    render jsonapi: object, status: status
  end
end