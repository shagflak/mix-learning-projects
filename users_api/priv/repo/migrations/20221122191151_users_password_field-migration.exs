defmodule :"Elixir.UsersApi.Repo.Migrations.UsersPasswordField-migration" do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :password, :text
  end
end
