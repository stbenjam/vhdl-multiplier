library ieee;
use ieee.std_logic_1164.all;
use work.components.all;
use ieee.numeric_std.all;

entity HARDWARE_MULTIPLIER is
  generic(
    N: integer := 32
  );
  port (
         MULTIPLICAND :  in std_ulogic_vector(31 downto 0);
         MULTIPLIER   :  in std_ulogic_vector(31 downto 0);
         RESULT       : out std_ulogic_vector(63 downto 0)
);
end entity HARDWARE_MULTIPLIER;

architecture DATAFLOW of HARDWARE_MULTIPLIER is
  type wordarray is array (0 to 31) of std_ulogic_vector(63 downto 0);
  signal multiplicands : wordarray;
  signal sums : wordarray;
begin

  multiplicandsGenerator: for I in 0 to N-1 generate
    multiplicands(I) <= (std_ulogic_vector(resize(unsigned(MULTIPLICAND), 64)) sll I) and MULTIPLIER(I);
  end generate;

  level0: for I in 0 to 15 generate
    add0: ADDER port map (
      A    => multiplicands(I*2),
      B    => multiplicands(I*2+1),
      CIN  => '0',
      SUM  => sums(I)
    );
  end generate;

  level1: for I in 0 to 7 generate
    add1: ADDER port map (
      A    => sums(I*2),
      B    => sums(I*2+1),
      CIN  => '0',
      SUM  => sums(I+16)
    );
  end generate;

  level2: for I in 0 to 3 generate
    add2: ADDER port map (
      A    => sums((I*2)+16),
      B    => sums((I*2)+17),
      CIN  => '0',
      SUM  => sums(I+24)
    );
  end generate;

  level3: for I in 0 to 1 generate
    add3: ADDER port map (
      A    => sums((I*2)+24),
      B    => sums((I*2+25)),
      CIN  => '0',
      SUM  => sums(I+28)
    );
  end generate;

  level4: ADDER port map (
    A    => sums(28),
    B    => sums(29),
    CIN  => '0',
    SUM  => RESULT
  );

end architecture DATAFLOW;
