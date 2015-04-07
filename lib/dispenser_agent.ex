defmodule TicketAgent do

	def start() do
		Agent.start_link(fn () -> 1 end)
	end

	def stop(agent) do
		Agent.stop(agent)
	end

	def take(agent) do
		Agent.get_and_update(agent, fn n -> {n, n+1} end)
	end
	
	def reset(agent) do
		Agent.update(agent, fn n -> 1 end)
		0
	end

end
