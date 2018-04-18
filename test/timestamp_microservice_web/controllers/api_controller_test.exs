defmodule TimestampMicroserviceWeb.ApiControllerTest do
  use TimestampMicroserviceWeb.ConnCase

  test "API handles valid natural dates", %{conn: conn} do
    conn1 = get conn, api_path(conn, :index, "1415-07-06")
    assert json_response(conn1, 200) == %{
      "timestamp" => -17498073600,
      "natural" => "1415-07-06"
    }

    conn2 = get conn, api_path(conn, :index, "1988-04-17")
    assert json_response(conn2, 200) == %{
      "timestamp" => 577238400,
      "natural" => "1988-04-17"
    }

    conn3 = get conn, api_path(conn, :index, "2066-12-26")
    assert json_response(conn3, 200) == %{
      "timestamp" => 3060547200,
      "natural" => "2066-12-26"
    }
  end

  test "API handles invalid natural dates", %{conn: conn} do
    conn1 = get conn, api_path(conn, :index, "2012-16-16")
    assert json_response(conn1, 200) == %{
      "error" => true,
      "reason" => "Invalid date"
    }

    conn2 = get conn, api_path(conn, :index, "1st March 2012")
    assert json_response(conn2, 200) == %{
      "error" => true,
      "reason" => "Invalid input format"
    }

    conn3 = get conn, api_path(conn, :index, "qwerty")
    assert json_response(conn3, 200) == %{
      "error" => true,
      "reason" => "Invalid input format"
    }
  end

  test "API handles valid timestamp", %{conn: conn} do
    conn1 = get conn, api_path(conn, :index, -62167219200)
    assert json_response(conn1, 200) == %{
      "timestamp" => -62167219200,
      "natural" => "0000-01-01"
    }

    conn2 = get conn, api_path(conn, :index, 0)
    assert json_response(conn2, 200) == %{
      "timestamp" => 0,
      "natural" => "1970-01-01"
    }

    conn3 = get conn, api_path(conn, :index, 924042898)
    assert json_response(conn3, 200) == %{
      "timestamp" => 924042898,
      "natural" => "1999-04-13"
    }

    conn4 = get conn, api_path(conn, :index, 2524042992)
    assert json_response(conn4, 200) == %{
      "timestamp" => 2524042992,
      "natural" => "2049-12-25"
    }
  end
    
  test "API handles invalid timestamp", %{conn: conn} do
    conn1 = get conn, api_path(conn, :index, -62167219201)
    assert json_response(conn1, 200) == %{
      "error" => true,
      "reason" => "Invalid unix time"
    }

    conn2 = get conn, api_path(conn, :index, 999999999999999999)
    assert json_response(conn2, 200) == %{
      "error" => true,
      "reason" => "Invalid unix time"
    }
  end
end
