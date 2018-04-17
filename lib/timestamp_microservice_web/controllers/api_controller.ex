defmodule TimestampMicroserviceWeb.ApiController do
  use TimestampMicroserviceWeb, :controller

  alias TimestampMicroservice.Api


  def index(conn, %{"input" => input}) do
    json conn, Api.prepare_response(input)
  end
end
