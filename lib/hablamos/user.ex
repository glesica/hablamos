defmodule Hablamos.User do
  use GenServer

  require Logger
  
  defstruct [:id, :username, :contacts]

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def serve(socket) do
    {:ok, pid} = __MODULE__.start_link()
    serve(socket, pid)
  end

  def serve(socket, pid) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    tokens = data
    |> String.strip
    |> String.split(" ", trim: true)
    resp = case tokens do
             ["create", u, p] ->
               GenServer.call(pid, {:create, u, p})
             ["connect", u, p] ->
               GenServer.call(pid, {:connect, u, p})
             ["whoami"] ->
               GenServer.call(pid, {:whoami})
             _ ->
               "error command-invalid"
           end
    :gen_tcp.send(socket, resp <> "\n")
    serve(socket, pid)
  end

  def init(_args) do
    {:ok, %__MODULE__{id: -1, username: "", contacts: []}}
  end

  def handle_call({:create, u, p}, _from, user) do
    Logger.info "Create: '#{u}' on #{inspect self}"
    case create_user(u, p) do
      :ok                 -> {:reply, "success", user}
      {:error, :password} -> {:reply, "password-invalid", user}
      {:error, :user}     -> {:reply, "username-invalid", user}
      {:error, :taken}    -> {:reply, "username-taken", user}
    end
  end
  
  def handle_call({:connect, u, p}, _from, user) do
    Logger.info "Connect: '#{u}' on #{inspect self}"
    case authenticate_user(u, p) do
      {:ok, new_user}     -> {:reply, "success", new_user}
      {:error, :password} -> {:reply, "error password-incorrect", user}
    end
  end

  def handle_call({:whoami}, _from, user) do
    case user.username do
      "" ->
        {:reply, "error unauthenticated", user}
      _ ->
        {:reply, "success #{user.username}", user}
    end
  end

  defp create_user(username, password) do
    :ok
  end

  defp authenticate_user(username, password) do
    {:ok, %__MODULE__{id: 0, username: username, contacts: [1, 2]}}
  end

  defp username_legal?(username) do
    true
  end

  defp password_legal?(password) do
    true
  end
  
end
