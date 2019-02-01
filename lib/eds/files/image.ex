defmodule Eds.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :large, :medium, :small]


  def storage_dir(version, {file, image}) do
    "priv/uploads/nodes/#{image.node_id}/images/#{image.id}"
  end

  def filename(version, {_file, _}) do
    version
  end

  def transform(:original, _), do: :noaction

  def transform(version, {_file, _scope}) do
    {:convert, "-strip -resize #{dimensions(version)}"}
  end



  defp dimensions(:large), do: "1200>"
  defp dimensions(:medium), do: "600>"
  defp dimensions(:small), do: "300>"
end
