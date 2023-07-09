defmodule KyoboGoldenTime do
  @moduledoc """
  Documentation for `KyoboGoldenTime`.
  """

  def fetch() do
    with %{status_code: 200, body: body} <-
           Crawly.fetch("https://www.kyobobook.co.kr/api/gw/onk/benefit/checkGoldenTimeNow"),
         {:ok, %{data: %{type: "READY", startTime: startTime}}} <-
           Jason.decode(body, keys: :atoms) do
      startTime
    else
      _ ->
        "error"
    end
    |> IO.puts()
  end
end
