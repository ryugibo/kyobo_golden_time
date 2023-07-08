defmodule Mix.Tasks.Fetch do
  use Mix.Task

  @shortdoc "Simply runs the Hello.say/0 command."
  def run(_) do
    Application.ensure_all_started(:httpoison)
    Application.ensure_all_started(:timex)
    # 앞서 만든 Hello.say() 함수 호출하기
    KyoboGoldenTime.fetch()
  end
end
