----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:23:23 04/17/2013 
-- Design Name: 
-- Module Name:    Shift - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shift is
    Port ( d : in  STD_LOGIC_VECTOR (31 downto 0);
           load : in  STD_LOGIC;
           dir : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (31 downto 0));
end Shift;

architecture Behavioral of Shift is
	signal interno : STD_LOGIC_VECTOR (31 downto 0);
begin
	process (clk) is
	begin
		if (rising_edge(clk)) then
			if (reset = '1') then --reset activo alto
				interno <= x"00000000";
			elsif (load = '1') then --le cargo la entrada
				interno <= d;
			elsif (dir = '1') then --corro a la derecha
				interno <= '0' & interno(31 downto 1);
			else
				interno <= interno(30 downto 0) & '0';
			end if;
		end if;
	end process;
	q <= interno;
end Behavioral;

