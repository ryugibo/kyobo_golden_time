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

    with {:ok, %HTTPoison.Response{status_code: 200, body: body}} <-
           HTTPoison.get("https://www.kyobobook.co.kr/api/gw/onk/benefit/checkGoldenTimeNow"),
         {:ok, %{data: %{type: "READY", startTime: start_time}}} <-
           Jason.decode(body, keys: :atoms),
         true <- prev_time != start_time || {:error, :not_changed} do
      File.write!("tmp/prev_result", start_time)
      start_time
    else
      _ ->
        "error"
    end
    |> IO.puts()
  end
end
