----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:08:39 04/24/2013 
-- Design Name: 
-- Module Name:    Banco_de_Registros - Behavioral 
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Banco_de_Registros is
    Port ( reg1_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           reg2_rd : in  STD_LOGIC_VECTOR (4 downto 0);
           reg_wr : in  STD_LOGIC_VECTOR (4 downto 0);
           data_wr : in  STD_LOGIC_VECTOR (31 downto 0);
           wr : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           data1_rd : out  STD_LOGIC_VECTOR (31 downto 0);
           data2_rd : out  STD_LOGIC_VECTOR (31 downto 0));
end Banco_de_Registros;

architecture Behavioral of Banco_de_Registros is
		type MEM_T is array (0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
		signal MEM: MEM_T;
		
begin
	--led1
	data1_rd <= MEM (conv_integer(reg1_rd)) when reg1_rd /= "00000" else
		X"00000000";
	--led2
	data2_rd <= MEM (conv_integer(reg2_rd)) when reg2_rd /= "00000" else
		X"00000000";
	--escritura
	process (clk, reset) is
	begin
		if ( reset = '1' ) then
			for i in 0 to 31 loop
				MEM(i) <= x"00000000";
			end loop;
		elsif ((falling_edge(clk)) and (wr = '1') and (not (reg_wr = "00000"))) then
				MEM (conv_integer(reg_wr)) <= data_wr;
		end if;
	end process;
end Behavioral;   

