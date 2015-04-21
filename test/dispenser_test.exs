defmodule StateTest do
  use ExUnit.Case

#	alias :ticket_dispenser, as: SUT
  alias TicketDispenser, as: SUT
	
	test "Ticket Dispenser" do
		{:ok, disp} = SUT.start()
		assert 1 == SUT.take(disp)
		assert 2 == SUT.take(disp)
		assert 3 == SUT.take(disp)
		SUT.reset(disp)
		assert 1 == SUT.take(disp)
		SUT.stop(disp)
  end

end
