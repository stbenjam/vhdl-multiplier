library ieee;
use ieee.std_logic_1164.all;

entity FULL_ADDER is
  port (
  A, B, CIN: in std_logic;
  SUM, COUT: out std_logic

);
end entity FULL_ADDER;

architecture DATAFLOW of FULL_ADDER is
begin
  SUM <= A xor B xor CIN;
  COUT <= (A and B) or (A and CIN) or
          (B and CIN);
end architecture DATAFLOW;
