----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:30:19 04/17/2013 
-- Design Name: 
-- Module Name:    Alu - Behavioral 
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
use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Alu is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           ctrl : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0);
           zero : out  STD_LOGIC);
end Alu;

architecture Behavioral of Alu is
	signal resultI: STD_LOGIC_VECTOR (31 downto 0);
begin
	process (ctrl, a, b) is
	begin
		case (ctrl) is
			when "000" => --And
				resultI <= a and b;
			when "001" => --Or
				resultI <= a or b;
			when "010" => --suma
				resultI<= a + b;
			when "110" => --resta
				resultI <= a - b;
		   when "111"  => --comparacion menor
			if (a < b) then
				resultI <= x"00000001";
			else 
				resultI <= x"00000000";
			end if; 
			when "100" => --corrimiento a la izquierda
				resultI <= b(30 downto 0) & '0';
			when others =>
				resultI <= x"00000000";
		end case;
	end process;
	
	result <= resultI;
	
	zero <= '1' when resultI= x"00000000" else
		'0';

end Behavioral;

