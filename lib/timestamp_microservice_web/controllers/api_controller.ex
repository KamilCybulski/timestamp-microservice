defmodule TimestampMicroserviceWeb.ApiController do
  use TimestampMicroserviceWeb, :controller


  def index(conn, %{"input" => input}) do
    json conn, prepare_response(input)
  end

  defp prepare_response(input) do
    case is_timestamp?(input) do
      true -> process_timestamp(input)
      false -> process_date(input)
    end
  end

  defp is_timestamp?(input) do
    String.match?(input, ~r/^\d+$/)
  end

  defp process_timestamp(ts) do
    %{ timestamp: ts, natural: parse_timestamp(ts) }
  end

  defp parse_timestamp(ts) do
    ts
    |> String.to_integer
    |> DateTime.from_unix
    |> (fn(dt) -> elem(dt, 1) end).()
    |> DateTime.to_date
  end

  defp process_date(input) do
    case Date.from_iso8601(input) do
      {:ok, date} -> %{ natural: date, timestamp: parse_date_to_timestamp(date)}
      {:error, :invalid_format} -> %{error: true, reason: "Invalid input format"}
      {:error, :invalid_date} -> %{error: true, reason: "Invalid date"}
    end 
  end

  defp parse_date_to_timestamp(d) do
    d
    |> Date.to_iso8601
    |> (fn(s) -> s <> "T00:00:00Z" end).()
    |> DateTime.from_iso8601
    |> (fn(dt) -> elem(dt, 1) end).()
    |> DateTime.to_unix
  end
end
