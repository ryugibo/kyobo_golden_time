defmodule KyoboGoldenTime do
  @moduledoc """
  Documentation for `KyoboGoldenTime`.
  """
  defp fetch_next_golden_time(document) do
    document
    |> Floki.find("#goldenTime")
    |> Floki.find(".time_group")
    |> Enum.map(&Floki.text(&1))
    |> Enum.reduce(Timex.now("Asia/Seoul"), fn
      _, :error ->
        :error

      <<"??", "분">>, _time ->
        :error

      <<"??", "초">>, _time ->
        :error

      <<min::binary-size(2), "분">>, time ->
        Timex.shift(time, minutes: String.to_integer(min))

      <<sec::binary-size(2), "초">>, time ->
        Timex.shift(time, seconds: String.to_integer(sec))
    end)
    |> case do
      :error -> :error
      time -> {:ok, time}
    end
  end

  def fetch() do
    with %{status_code: 200, body: body} <-
           Crawly.fetch("https://www.kyobobook.co.kr/benefit"),
         {:ok, document} <- Floki.parse_document(body),
         {:ok, time} <- fetch_next_golden_time(document) do
      time
    else
      error ->
        error
    end
    |> IO.inspect()
  end
end
