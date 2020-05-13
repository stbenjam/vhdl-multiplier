library ieee;
use ieee.std_logic_1164.all;
use work.components.all;
use ieee.numeric_std.all;

entity MULTIPLIER_TB is
  end entity MULTIPLIER_TB;

architecture BEHAV of MULTIPLIER_TB is
  signal a   : std_ulogic_vector(31 downto 0);
  signal b   : std_ulogic_vector(31 downto 0);
  signal result : std_ulogic_vector(63 downto 0);
begin
  MULT0 : HARDWARE_MULTIPLIER
  port map (
             MULTIPLIER     => a,
             MULTIPLICAND     => b,
             RESULT => result
           );

  MULT_TB : process
  begin
    a <= std_ulogic_vector(to_unsigned(32, a'length));
    b <= std_ulogic_vector(to_unsigned(32, a'length));
    wait for 10 ns;
    assert result = X"0000000000000400";
    report "32 * 32 = 0x" & to_hstring(result);

    a <= std_ulogic_vector(to_unsigned(16384, a'length));
    b <= std_ulogic_vector(to_unsigned(32764, a'length));
    wait for 10 ns;
    assert result = X"000000001FFF0000";
    report "16384 * 32764 = 0x" & to_hstring(result);

    a <= X"FFFFFFFF";
    b <= X"FFFFFFFF";
    wait for 10 ns;
    assert result = X"FFFFFFFE00000001";
    report "4294967295 * 4294967295 = 0x" & to_hstring(result);

    wait;

  end process MULT_TB;
end architecture BEHAV;
