defmodule TimestampMicroserviceWeb.Router do
  use TimestampMicroserviceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TimestampMicroserviceWeb do
    pipe_through :browser # Use the default browser stack

    get "/", UsageController, :index
  end

  scope "/api", TimestampMicroserviceWeb do
    pipe_through :api

    get "/:input", ApiController, :index
  end
end
