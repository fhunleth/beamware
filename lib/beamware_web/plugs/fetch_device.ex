defmodule BeamwareWeb.Plugs.FetchDevice do
  import Plug.Conn

  alias Beamware.Devices

  def init(opts) do
    opts
  end

  def call(%{assigns: %{tenant: tenant}, params: %{"device_id" => device_id}} = conn, _opts) do
    tenant
    |> Devices.get_device(device_id)
    |> case do
      {:ok, device} ->
        conn
        |> assign(:device, device)

      _ ->
        conn
        |> halt()
    end
  end
end
