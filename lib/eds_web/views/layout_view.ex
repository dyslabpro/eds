defmodule EdsWeb.LayoutView do
  use EdsWeb, :public_view

  def category_list do
    categories = Eds.Repo.all(Eds.Core.Category)
  end
end
