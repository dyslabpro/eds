defmodule EdsWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use EdsWeb, :controller
      use EdsWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: EdsWeb
      import Plug.Conn
      import EdsWeb.Router.Helpers
      import EdsWeb.Gettext
      alias Eds.Repo
      import Ecto
      import Ecto.Query
      import EdsWeb.Plug.Conn
    end
  end

  def admin_view do
    quote do
      use Phoenix.View,
        root: "lib/eds_web/templates",
        namespace: EdsWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import EdsWeb.Router.Helpers
      import EdsWeb.ErrorHelpers
      import EdsWeb.Gettext
      import Eds.Helpers.AdminHelpers
    end
  end

  def public_view do
    quote do
      use Phoenix.View,
        root: "lib/eds_web/templates",
        namespace: EdsWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import EdsWeb.Router.Helpers
      import EdsWeb.ErrorHelpers
      import EdsWeb.Gettext
      import Eds.Helpers.AdminHelpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import EdsWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
