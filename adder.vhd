library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity ADDER is
  generic(
    N: integer := 64
  );
  port (
    CIN:      in std_ulogic;
    A, B:     in std_ulogic_vector(N-1 downto 0);
    SUM:     out std_ulogic_vector(N-1 downto 0);
    COUT:    out std_ulogic
  );
end entity ADDER;

architecture behavior of ADDER is
  signal carries: std_logic_vector(N downto 0);
begin
  carries(0) <= CIN;

  fullAdderGenerator: for I in 0 to N-1 generate
    fullAdders: FULL_ADDER port map (
      A    => A(I),
      B    => B(I),
      SUM  => SUM(I),
      CIN  => carries(I),
      COUT => carries(I + 1)
    );
  end generate;

  COUT <= carries(N);
end architecture behavior;
