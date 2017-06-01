defmodule Retrodoc.ReactionTest do
  use Retrodoc.ModelCase

  alias Retrodoc.Reaction

  @valid_attrs %{emoji: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Reaction.changeset(%Reaction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Reaction.changeset(%Reaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
