defmodule KyoboGoldenTime do
  @moduledoc """
  Documentation for `KyoboGoldenTime`.
  """

  @prev_directory "tmp/"
  @prev_file_path "#{@prev_directory}prev_result"

  defp get_prev_result() do
    unless File.exists?(@prev_directory) do
      File.mkdir(@prev_directory)
    end

    File.read(@prev_file_path)
    |> case do
      {:ok, prev_time} ->
        prev_time

      _ ->
        nil
    end
  end

  def fetch() do
    prev_time = get_prev_result()

    with %{status_code: 200, body: body} <-
           Crawly.fetch("https://www.kyobobook.co.kr/api/gw/onk/benefit/checkGoldenTimeNow"),
         {:ok, %{data: %{type: "READY", startTime: startTime}}} <-
           Jason.decode(body, keys: :atoms),
         true <- prev_time != startTime || {:error, :not_changed} do
      File.write!("tmp/prev_result", startTime)
      startTime
    else
      _ ->
        "error"
    end
    |> IO.puts()
  end
end
