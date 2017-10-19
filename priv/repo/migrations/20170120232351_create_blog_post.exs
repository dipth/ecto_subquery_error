defmodule Helheim.Repo.Migrations.CreateBlogPost do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string, null: false
      add :body, :text, null: false

      timestamps()
    end
  end
end
