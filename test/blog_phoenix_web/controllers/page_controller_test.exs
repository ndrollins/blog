defmodule BlogPhoenixWeb.PageControllerTest do
  use BlogPhoenixWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
  
  test "GET /shop", %{conn: conn} do
    conn = get(conn, "/shop")
    assert html_response(conn, 200) =~ "Welcome to the shop!"
  end
end
