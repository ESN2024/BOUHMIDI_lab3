library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity bin_to_7seg is
  port (
		bcd : in std_logic_vector(3 downto 0); 
		leds : out std_logic_vector(6 downto 0)
		);
end entity bin_to_7seg;


architecture rtl of bin_to_7seg is 
begin
process(bcd)
begin
		 case bcd is
		 when "0000" => leds <= "1000000"; -- "0"     
		 when "0001" => leds <= "1111001"; -- "1" 
		 when "0010" => leds <= "0100100"; -- "2" 
		 when "0011" => leds <= "0110000"; -- "3" 
		 when "0100" => leds <= "0011001"; -- "4" 
		 when "0101" => leds <= "0010010"; -- "5" 
		 when "0110" => leds <= "0000010"; -- "6" 
		 when "0111" => leds <= "1111000"; -- "7" 
		 when "1000" => leds <= "0000000"; -- "8"     
		 when "1001" => leds <= "0010000"; -- "9"
		 when others => leds <= "0111111"; --- "sign -"
		 end case;
end process; 
end architecture rtl;