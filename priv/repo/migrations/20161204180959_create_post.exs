defmodule Retrodoc.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :string
      add :username, :string

      timestamps()
    end

  end
end
