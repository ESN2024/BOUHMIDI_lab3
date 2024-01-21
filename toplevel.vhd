library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity toplevel is
	port (
			clk			: in 	std_logic;
			reset			: in 	std_logic;
			SDA			: inout	std_logic;
			SCL			: inout	std_logic;
			slct 			: in  std_logic;
			seg1    		: out std_logic_vector(20 downto 0);
			seg2    		: out std_logic_vector(20 downto 0)
	);
end entity toplevel;


architecture rtl of toplevel is

    component lab3 is
        port (
            clk_clk           : in    std_logic                     := 'X';             -- clk
            reset_reset_n     : in    std_logic                     := 'X';             -- reset_n
            seg_1_export      : out   std_logic_vector(11 downto 0);                    -- export
            seg_2_export      : out   std_logic_vector(11 downto 0);                    -- export
            select_export     : in    std_logic                     := 'X'; -- export
            s_data_scl_pad_io : inout std_logic                     := 'X';             -- scl_pad_io
            s_data_sda_pad_io : inout std_logic                     := 'X'              -- sda_pad_io
        );
    end component lab3;
	 component bin_to_7seg is
		  port (
				bcd : in std_logic_vector(3 downto 0); 
				leds : out std_logic_vector(6 downto 0)
		);
	 end component bin_to_7seg;
	 
	 signal bcd_int1 : std_logic_vector(11 downto 0);
	 signal bcd_int2 : std_logic_vector(11 downto 0);  

begin	 
	 
		 u0 : component lab3
			  port map (
					clk_clk           => clk,           --    clk.clk
					reset_reset_n     => reset,     --  reset.reset_n
					seg_1_export      => bcd_int1,      --  seg_1.export
					seg_2_export      => bcd_int2,      --  seg_2.export
					select_export     => slct ,     -- select.export
					s_data_scl_pad_io => SCL, -- s_data.scl_pad_io
					s_data_sda_pad_io => SDA  --       .sda_pad_io
			  );
		u1 : component bin_to_7seg
			port map (
				bcd => bcd_int1(11 downto 8),
				leds => seg1(20 downto 14)
			);
		u2 : component bin_to_7seg
			port map (
				bcd => bcd_int1(7 downto 4),
				leds => seg1(13 downto 7)
			);

		u3 : component bin_to_7seg
			port map (
				bcd => bcd_int1(3 downto 0),
				leds => seg1(6 downto 0)
			);
		u4 : component bin_to_7seg
			port map (
				bcd => bcd_int2(11 downto 8),
				leds => seg2(20 downto 14)
			);
		u5 : component bin_to_7seg
			port map (
				bcd => bcd_int2(7 downto 4),
				leds => seg2(13 downto 7)
			);

		u6 : component bin_to_7seg
			port map (
				bcd => bcd_int2(3 downto 0),
				leds => seg2(6 downto 0)
			);

end architecture rtl;
