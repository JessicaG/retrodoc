defmodule Retrodoc.SessionControllerTest do
  use Retrodoc.ConnCase

  alias Retrodoc.Registration
  alias Retrodoc.User

  @user_params %{"email" => "a@b.com", "password" => "monkey"}

  setup do
    Registration.create(User.changeset(%User{}, @user_params), Repo)
    :ok
  end

  test "unauthenticated user requests login page" do
    conn = get conn, "/login"
    assert html_response(conn, 200) =~ "Login"
  end

  test "unauthenticated user submits valid credentials" do
    conn = post conn, "/login", session: @user_params
    assert html_response(conn, 302)
  end
end
