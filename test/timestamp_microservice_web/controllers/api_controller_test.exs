defmodule TimestampMicroserviceWeb.ApiControllerTest do
  use TimestampMicroserviceWeb.ConnCase

  test "API input 2005-06-12", %{conn: conn} do
    conn = get conn, api_path(conn, :index, "2005-06-12")
    assert json_response(conn, 200) == %{"timestamp" => 1118534400, "natural" => "2005-06-12"}
  end

  test "API input 1988-04-17", %{conn: conn} do
    conn = get conn, api_path(conn, :index, "1988-04-17")
    assert json_response(conn, 200) == %{"timestamp" => 577238400, "natural" => "1988-04-17"}
  end

  test "API input 2066-12-26", %{conn: conn} do
    conn = get conn, api_path(conn, :index, "2066-12-26")
    assert json_response(conn, 200) == %{"timestamp" => 3060547200, "natural" => "2066-12-26"}
  end

  test "GET input 1522950532" do
    conn = get conn, api_path(conn, :index, "1522950532")
    assert json_response(conn, 200) == %{"timestamp" => 1522950532, "natural" => "2018-04-05"}
  end

  test "GET input 1582966632" do
    conn = get conn, api_path(conn, :index, "1582966632")
    assert json_response(conn, 200) == %{"timestamp" => 1582966632, "natural" => "2020-02-29"}
  end

  test "GET input 982966632" do
    conn = get conn, api_path(conn, :index, "982966632")
    assert json_response(conn, 200) == %{"timestamp" => 982966632, "natural" => "2001-02-23"}
  end
end
