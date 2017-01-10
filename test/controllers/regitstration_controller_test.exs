defmodule Retrodoc.RegistrationControllerTest do
  use Retrodoc.ConnCase

  @user_params %{"email" => "a@b.com", "password" => "monkey"}

  test "new user registers an account", %{conn: conn} do
    conn = post conn, "/registrations", user: @user_params
    assert html_response(conn, 302)
    conn = get conn, "/"
    assert html_response(conn, 200) =~ ~r/Your account was created/
  end
end
