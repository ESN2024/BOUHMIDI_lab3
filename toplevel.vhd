library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity toplevel is
	port (
		
	);
end entity toplevel;


architecture rtl of toplevel is

    component lab3 is
        port (
            clk_clk           : in    std_logic                     := 'X';             -- clk
            reset_reset_n     : in    std_logic                     := 'X';             -- reset_n
            seg_1_export      : out   std_logic_vector(11 downto 0);                    -- export
            seg_2_export      : out   std_logic_vector(11 downto 0);                    -- export
            select_export     : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
            s_data_scl_pad_io : inout std_logic                     := 'X';             -- scl_pad_io
            s_data_sda_pad_io : inout std_logic                     := 'X'              -- sda_pad_io
        );
    end component lab3;

begin	 
	 
    u0 : component lab3
        port map (
            clk_clk           => CONNECTED_TO_clk_clk,           --    clk.clk
            reset_reset_n     => CONNECTED_TO_reset_reset_n,     --  reset.reset_n
            seg_1_export      => CONNECTED_TO_seg_1_export,      --  seg_1.export
            seg_2_export      => CONNECTED_TO_seg_2_export,      --  seg_2.export
            select_export     => CONNECTED_TO_select_export,     -- select.export
            s_data_scl_pad_io => CONNECTED_TO_s_data_scl_pad_io, -- s_data.scl_pad_io
            s_data_sda_pad_io => CONNECTED_TO_s_data_sda_pad_io  --       .sda_pad_io
        );

end architecture rtl;
