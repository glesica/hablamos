defmodule Hablamos.Listener do
  require Logger

  @listen_opts [:binary,
                packet: :line,
                active: false]

  def accept(port) do
    {:ok, socket} = :gen_tcp.listen(port, @listen_opts)
    Logger.info "Listening on port #{port}"
    accept_loop(socket)
  end

  defp accept_loop(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Logger.info "Received connection #{inspect client}"
    {:ok, pid} = Task.Supervisor.start_child(Hablamos.Listener.Supervisor,
                                             Hablamos.User, :serve, [client])
    :gen_tcp.controlling_process(socket, pid)
    accept_loop(socket)
  end

end
