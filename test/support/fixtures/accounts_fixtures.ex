defmodule EctoPeople.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EctoPeople.Accounts` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{
        age: 42,
        last_name: "some last_name",
        name: "some name",
        occupation: "some occupation"
      })
      |> EctoPeople.Accounts.create_person()

    person
  end
end
