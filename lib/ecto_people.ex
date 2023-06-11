defmodule EctoPeople do

  alias EctoPeople.{Repo, Accounts.Person}

  @moduledoc """
  EctoPeople keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def parseCSV() do
    File.stream!("C:\\Users\\fabia\\elixir\\ectoplay\\lib\\assets\\elixir_test.csv")
    |> Stream.drop(1)
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.split(&1, ","))
    |> Enum.map(fn [name, last_name, age, occupation]->
      age = String.to_integer(age)
      the_person = Person.changeset(%Person{}, %{
        name: String.capitalize(name),
        last_name: String.capitalize(last_name),
        age: age,
        occupation: String.capitalize(occupation)
      })
      Repo.insert(the_person)
    end)
  end

end
