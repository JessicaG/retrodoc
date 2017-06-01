defmodule Retrodoc.Reaction do
  use Retrodoc.Web, :model

  schema "reactions" do
    field :emoji, :string
    has_one :user, Retrodoc.User
    belongs_to :post, Retrodoc.Post
    
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:emoji])
    |> validate_required([:emoji])
  end
end
