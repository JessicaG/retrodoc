defmodule Retrodoc.Repo.Migrations.CreateReaction do
  use Ecto.Migration

  def change do
    create table(:reactions) do
      add :emoji, :string
      add :post_id, references(:posts, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:reactions, [:post_id])
    create index(:reactions, [:user_id])

  end
end
