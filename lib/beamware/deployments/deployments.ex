defmodule Beamware.Deployments do
  import Ecto.Query

  alias Beamware.Deployments.Deployment
  alias Beamware.Accounts.Tenant
  alias Beamware.Repo
  alias Ecto.Changeset

  @spec get_deployments_by_tenant(integer()) :: [Deployment.t()]
  def get_deployments_by_tenant(tenant_id) do
    from(
      d in Deployment,
      where: d.tenant_id == ^tenant_id,
      join: f in assoc(d, :firmware),
      preload: [firmware: f]
    )
    |> Repo.all()
  end

  @spec get_deployment(Tenant.t(), String.t()) :: {:ok, Deployment.t()} | {:error, :not_found}
  def get_deployment(%Tenant{id: tenant_id}, deployment_id) do
    from(
      d in Deployment,
      where: d.tenant_id == ^tenant_id,
      where: d.id == ^deployment_id
    )
    |> Repo.one()
    |> case do
      nil ->
        {:error, :not_found}

      deployment ->
        {:ok, deployment}
    end
  end

  @spec create_deployment(Tenant.t(), map) :: {:ok, Deployment.t()} | {:error, Changeset.t()}
  def create_deployment(tenant, params) do
    params = Map.put(params, "is_active", false)

    tenant
    |> Ecto.build_assoc(:deployments)
    |> Deployment.changeset(params)
    |> Repo.insert()
  end

  @spec toggle_is_active(Deployment.t()) :: {:ok, Deployment.t()} | {:error, Changeset.t()}
  def toggle_is_active(%Deployment{} = deployment) do
    deployment
    |> Deployment.changeset(%{is_active: !deployment.is_active})
    |> Repo.update()
  end
end
