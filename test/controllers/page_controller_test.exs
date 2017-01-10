defmodule Retrodoc.PageControllerTest do
  use Retrodoc.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello Retrodoc!"
  end
end
