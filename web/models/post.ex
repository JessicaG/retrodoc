defmodule Retrodoc.Post do
  use Retrodoc.Web, :model

  schema "posts" do
    field :body, :string
    field :username, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> cast(params, [:username])
    |> validate_required([:body])
    |> validate_required([:username])
  end
end
