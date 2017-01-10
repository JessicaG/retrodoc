defmodule Retrodoc.UserTest do
  use Retrodoc.ModelCase

  alias Retrodoc.User

  @valid_attrs %{password: "some content", email: "user@domain.tld"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?, changeset.errors
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
