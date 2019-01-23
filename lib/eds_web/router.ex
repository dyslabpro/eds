defmodule EdsWeb.Router do
  use EdsWeb, :router

  alias EdsWeb.Plug

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(Plug.Turbolinks)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Plug.Auth, repo: Eds.Repo)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :admin do
    plug(:put_layout, {EdsWeb.LayoutView, :admin})
    plug Plug.RequireAdmin
    plug NavigationHistory.Tracker
  end

  scope "/auth", EdsWeb do
    pipe_through([:browser])

    # get("/:provider", AuthController, :request)
    # get("/:provider/callback", AuthController, :callback)
    # post("/:provider/callback", AuthController, :callback)
    for provider <- ~w(facebook) do
      get("/#{provider}", AuthController, :request, as: "#{provider}_auth")
      get("/#{provider}/callback", AuthController, :callback, as: "#{provider}_auth")
      post("/#{provider}/callback", AuthController, :callback, as: "#{provider}_auth")
    end
  end

  scope "/admin", EdsWeb.Admin, as: :admin do
    pipe_through([:browser, :admin])

    get("/", PageController, :index)

    resources("/nodes", NodeController) do
      resources("/texts", TextController)
    end

    resources "/chapters", ChapterController, only: [] do
      resources("/nodes", NodeController)
    end

    resources "/sections", SectionController, only: [] do
      resources("/nodes", NodeController)
    end

    resources "/courses", CourseController do
      resources("/nodes", NodeController)

      resources "/chapters", ChapterController do
        resources("/sections", SectionController)
      end
    end
  end

  scope "/", EdsWeb do
    # Use the default browser stack
    pipe_through(:browser)
    get("/category/:id", PageController, :category)

    resources "/courses", CourseController do
      resources "/chapters", ChapterController do
        resources("/sections", SectionController)
      end
    end

    # user and auth
    resources("/users", UserController, only: [:new, :create])
    get("/in", AuthController, :new, as: :sign_in)
    post("/in", AuthController, :new, as: :sign_in)
    get("/in/:token", AuthController, :create, as: :sign_in)
    get("/out", AuthController, :delete, as: :sign_out)

    # static pages
    get("/", PageController, :home)
    get("/index", PageController, :index)
    get("/dashboard", UserController, :dashboard)
  end

  # Other scopes may use custom stacks.
  # scope "/api", EdsWeb do
  #   pipe_through :api
  # end
end
