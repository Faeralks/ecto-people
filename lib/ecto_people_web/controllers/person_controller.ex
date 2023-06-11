defmodule EctoPeopleWeb.PersonController do
  use EctoPeopleWeb, :controller

  alias EctoPeople.Accounts
  alias EctoPeople.Accounts.Person

  def index(conn, _params) do
    people = Accounts.list_people()
    render(conn, :index, people: people)
  end

  def new(conn, _params) do
    changeset = Accounts.change_person(%Person{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"person" => person_params}) do
    case Accounts.create_person(person_params) do
      {:ok, person} ->
        conn
        |> put_flash(:info, "Person created successfully.")
        |> redirect(to: ~p"/people/#{person}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    person = Accounts.get_person!(id)
    render(conn, :show, person: person)
  end

  def edit(conn, %{"id" => id}) do
    person = Accounts.get_person!(id)
    changeset = Accounts.change_person(person)
    render(conn, :edit, person: person, changeset: changeset)
  end

  def update(conn, %{"id" => id, "person" => person_params}) do
    person = Accounts.get_person!(id)

    case Accounts.update_person(person, person_params) do
      {:ok, person} ->
        conn
        |> put_flash(:info, "Person updated successfully.")
        |> redirect(to: ~p"/people/#{person}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, person: person, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    person = Accounts.get_person!(id)
    {:ok, _person} = Accounts.delete_person(person)

    conn
    |> put_flash(:info, "Person deleted successfully.")
    |> redirect(to: ~p"/people")
  end
end
