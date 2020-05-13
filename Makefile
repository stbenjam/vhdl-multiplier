GHDL=ghdl
GFLAGS=--std=08
GTKWAVE=gtkwave

BIN=multiplier_tb
SRCS=components.vhd full_adder.vhd adder.vhd multiplier.vhd multiplier_tb.vhd
OBJS=$(subst .vhd,.o,$(SRCS))

test: $(OBJS) $(BIN)
		./$(BIN) --vcd=$(BIN).vcd

view:
		$(GTKWAVE) $(BIN).vcd

%: %.o
		$(GHDL) -e $(GFLAGS) $@

%.o: %.vhd
		$(GHDL) -a $(GFLAGS) $<

clean:
		rm -f $(BIN) $(OBJS) work*.cf *.o *.vcd
