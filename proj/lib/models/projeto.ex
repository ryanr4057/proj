defmodule Proj.Projeto do
  use Ecto.Schema
  use Assoc.Schema, repo: Proj.Repo

  schema "projetos" do
    field(:nome, :string)
    field(:descricao, :string)
    field(:data_ini, :date)
    field(:data_term, :date)
    field(:status, :string)

    belongs_to(:responsavel, Proj.Membro, foreign_key: :id_responsavel, on_replace: :update)
    many_to_many(:membros, Proj.Membro, join_through: "membros_projetos", on_replace: :delete)
  end

  def updatable_associations, do: [
    membros: Proj.Membro
  ]

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:nome, :descricao, :data_ini, :data_term, :status])
    |> Ecto.Changeset.validate_required([:nome, :status])
  end

end
