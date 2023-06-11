defmodule EctoPeople.AccountsTest do
  use EctoPeople.DataCase

  alias EctoPeople.Accounts

  describe "people" do
    alias EctoPeople.Accounts.Person

    import EctoPeople.AccountsFixtures

    @invalid_attrs %{age: nil, last_name: nil, name: nil, occupation: nil}

    test "list_people/0 returns all people" do
      person = person_fixture()
      assert Accounts.list_people() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Accounts.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      valid_attrs = %{age: 42, last_name: "some last_name", name: "some name", occupation: "some occupation"}

      assert {:ok, %Person{} = person} = Accounts.create_person(valid_attrs)
      assert person.age == 42
      assert person.last_name == "some last_name"
      assert person.name == "some name"
      assert person.occupation == "some occupation"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      update_attrs = %{age: 43, last_name: "some updated last_name", name: "some updated name", occupation: "some updated occupation"}

      assert {:ok, %Person{} = person} = Accounts.update_person(person, update_attrs)
      assert person.age == 43
      assert person.last_name == "some updated last_name"
      assert person.name == "some updated name"
      assert person.occupation == "some updated occupation"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_person(person, @invalid_attrs)
      assert person == Accounts.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Accounts.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Accounts.change_person(person)
    end
  end
end
