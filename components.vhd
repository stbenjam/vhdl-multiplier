library ieee;
use ieee.std_logic_1164.all;

package components is
  component FULL_ADDER is
    port (
    A, B, CIN: in std_logic;
    SUM, COUT: out std_logic
  );
  end component FULL_ADDER;

  component ADDER is
    generic(
             N: integer := 64
           );
    port (
           CIN:      in std_ulogic;
    A, B:     in std_ulogic_vector(N-1 downto 0);
    SUM:     out std_ulogic_vector(N-1 downto 0);
    COUT:    out std_ulogic
  );
  end component ADDER;

  component HARDWARE_MULTIPLIER is
    generic(
             N: integer := 32
           );
    port (
           MULTIPLICAND :  in std_ulogic_vector(N-1 downto 0);
           MULTIPLIER   :  in std_ulogic_vector(N-1 downto 0);
           RESULT       : out std_ulogic_vector(N*2-1 downto 0)
         );
  end component HARDWARE_MULTIPLIER;
end components;

