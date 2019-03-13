defmodule EdsApiWeb.Router do
  use EdsApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EdsApiWeb do
    pipe_through :api

    resources "/courses", CourseController, only: [:show, :index]

  end
end
