defmodule TimestampMicroserviceWeb.UsageController do
  use TimestampMicroserviceWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
