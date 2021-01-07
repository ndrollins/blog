defmodule BlogPhoenix.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :content, :string
    field :name, :string
    belongs_to :post, BlogPhoenix.Post, foreign_key: :post_id

    timestamps()
  end
  @required_fields ~w(name content post_id)
  @optional_fields ~w()
  @doc """
  Creates a changeset based on the model and the params. If the params are nil, an invalid changeset is returned with no validation performed.
  """
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:name, :content])
    |> validate_required([:name, :content, :post_id])
  end
end
