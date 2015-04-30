defmodule Hablamos.Directory do
  use GenServer
  alias Hablamos.User

  @name __MODULE__

  def start_link(opts \\ []) do
    GenServer.start_link(@name, HashSet.new, opts)
  end

  def add_user(user=%User{}) do
    GenServer.cast(@name, {:add, user})
  end

  def drop_user(user=%User{}) do
    GenServer.cast(@name, {:drop, user})
  end

  def handle_cast({:add, user=%User{}}, actives) do
    {:noreply, Set.put(actives, user)}
  end

  def handle_cast({:drop, user=%User{}}, actives) do
    {:noreply, Set.delete(actives, user)}
  end

end
