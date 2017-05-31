defmodule Retrodoc.RoomChannel do
  use Retrodoc.Web, :channel
  alias Retrodoc.Presence
  alias Retrodoc.Post

  def join("room:january", _, socket) do
    send self(), :after_join
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    Presence.track(socket, socket.assigns.user, %{
      online_at: :os.system_time(:milli_seconds)
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def handle_in("message:new", message, socket) do
    msg = %{
      user: socket.assigns.user,
      body: message,
      timestamp: :os.system_time(:milli_seconds)
    }

    broadcast! socket, "message:new", msg
    post_params = %{
      username: msg[:user],
      body: msg[:body]
    }
    changeset = Post.changeset(%Post{}, post_params)
    Repo.insert(changeset)


    {:noreply, socket}
  end
end
