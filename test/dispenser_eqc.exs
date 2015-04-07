defmodule TicketDispenser_eqc do
	use ExUnit.Case, async: false
	use EQC.ExUnit
	use EQC.StateM

	#alias :ticket_dispenser, as: SUT
	#alias TicketDispenser, as: SUT
	alias TicketAgent, as: SUT

	def initial_state() do 0 end
	
## reset command
	def reset_args(_state) do [var: :pid] end

	def reset(pid) do SUT.reset(pid) end

	def reset_next(_state, _var, [_pid]) do 0 end
	
#	def reset_post(_state, [_pid], result) do	eq(result, 0) end

## take command
	def take_args(_state) do [var: :pid] end

	def take(pid) do SUT.take(pid) end

	def take_next(state, _var, [_pid]) do state+1 end
	
	def take_post(state, [_pid], result) do eq(result, state+1) end


#	weight state,
#	   take: 10,
#    reset: state
  	
	property "random ticket sequence" do
		forall cmds <- parallel_commands(__MODULE__) do
			{:ok, pid} = SUT.start()
			run_result =
				run_parallel_commands(__MODULE__, cmds, [pid: pid])
			SUT.stop(pid)
			pretty_commands(__MODULE__, cmds, run_result,
											run_result[:result] == :ok)
		end
	end
	
end

