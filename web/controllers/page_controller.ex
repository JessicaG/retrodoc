defmodule Retrodoc.PageController do
  use Retrodoc.Web, :controller
  alias Retrodoc.Post
  #plug Plug.Session

  def index(conn, _params) do
    posts = Repo.all from p in Post, preload: [:reactions]
    #csrf_token = Plug.Conn.get_session(conn, :csrf_token)
    render(conn, "index.html", posts: posts)
  end
end
