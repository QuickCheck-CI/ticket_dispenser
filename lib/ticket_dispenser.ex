defmodule TicketDispenser do
	use GenServer

	def start() do
		GenServer.start(__MODULE__, 1, [])
	end

	def stop(server) do
		GenServer.call(server, :stop)
	end

	def take(server) do
		n = GenServer.call(server, :read)
		GenServer.call(server, {:write, n+1})
	end
	
	def reset(server) do
		GenServer.call(server, {:write, 1})
	end

	
	## server callbacks
	
	def init(n) do
    {:ok, n}
  end

  def handle_call(:read, _from, n) do
    {:reply, n, n}
  end
	def handle_call({:write, m}, _from, n) do
    {:reply, n, m}
  end
	def handle_call(:stop, _from, n) do
    {:stop, :normal, n, n}
	end

end
