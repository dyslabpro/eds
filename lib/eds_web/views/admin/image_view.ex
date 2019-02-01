defmodule EdsWeb.Admin.ImageView do
  use EdsWeb, :admin_view

  def position_options do
    Eds.Content.Image.Position.__enum_map__()
    |> Enum.map(fn({k, _v}) -> {String.capitalize(Atom.to_string(k)), k} end)
  end

end
