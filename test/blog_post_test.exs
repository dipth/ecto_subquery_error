defmodule MyApp.BlogPostTest do
  alias MyApp.BlogPost
  alias MyApp.Repo

  use ExUnit.Case, async: true

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MyApp.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(MyApp.Repo, {:shared, self()})
    :ok
  end

  describe "newest_for_frontpage/2" do
    test "does not raise an error" do
      BlogPost.newest_for_frontpage(8)
      |> Repo.all
    end
  end
end
