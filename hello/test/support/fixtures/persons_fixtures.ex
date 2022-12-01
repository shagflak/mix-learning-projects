defmodule Hello.PersonsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Persons` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Hello.Persons.create_person()

    person
  end
end
