defmodule EctoPeople.Accounts.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :age, :integer
    field :last_name, :string
    field :name, :string
    field :occupation, :string
    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:name, :last_name, :age, :occupation])
    |> validate_required([:name, :last_name, :age, :occupation])
  end
end
