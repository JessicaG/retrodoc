defmodule Retrodoc.ReactionController do
  use Retrodoc.Web, :controller

  alias Retrodoc.Reaction

  def create(conn, %{"reaction" => reaction_params}) do
    changeset = Reaction.changeset(%Reaction{}, reaction_params)

    case Repo.insert(changeset) do
      {:ok, _reaction} ->
        conn
         #|> put_flash(:info, "Reaction created successfully.")
      {:error, changeset} ->
      	 #|> put_flash(:error, "Could not post reaction")
    end
  end

  def delete(conn, %{"id" => id}) do
    reaction = Repo.get!(Reaction, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(reaction)

    conn
    |> put_flash(:info, "Reaction deleted successfully.")
  end
end