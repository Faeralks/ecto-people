defmodule CSVParser do
  use GenServer
  alias EctoPeople.{Repo, Accounts.Person}

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: :csv_parser)
  end

  def parse_csv do
    GenServer.call(:csv_parser, :parse)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call(:parse, _, state) do
    parsed_data = parse()
    {:reply, parsed_data, state}
  end

  defp parse do
    File.stream!("./assets/elixir_test.csv")
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
