defmodule Retrodoc.PageController do
  use Retrodoc.Web, :controller
  alias Retrodoc.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end
end
