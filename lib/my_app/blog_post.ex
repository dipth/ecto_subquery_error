defmodule MyApp.BlogPost do
  alias MyApp.Repo

  use Ecto.Schema
  import Ecto
  import Ecto.Changeset
  import Ecto.Query

  schema "blog_posts" do
    field :title,         :string
    field :body,          :string

    timestamps()
  end

  def newest_for_frontpage(limit) do
    sq = from(
      bp in (MyApp.BlogPost),
      select: %{id: bp.id, row_number: fragment("row_number() OVER (PARTITION BY ? ORDER BY ? DESC)", bp.user_id, bp.updated_at)}
    )

    from(
      bp in (MyApp.BlogPost),
      join: rn in subquery(sq), on: rn.id == bp.id,
      where: rn.row_number == 1,
      limit: 8
    )
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
  end
end
