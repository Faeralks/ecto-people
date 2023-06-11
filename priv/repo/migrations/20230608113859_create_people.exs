defmodule EctoPeople.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string
      add :last_name, :string
      add :age, :integer
      add :occupation, :string

      timestamps()
    end
  end
end
