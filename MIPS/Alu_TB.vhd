--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:39:53 04/24/2013
-- Design Name:   
-- Module Name:   E:/Arqui1GS/Practico1/Alu_TB.vhd
-- Project Name:  Practico1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Alu_TB IS
END Alu_TB;
 
ARCHITECTURE behavior OF Alu_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Alu
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         b : IN  std_logic_vector(31 downto 0);
         ctrl : IN  std_logic_vector(2 downto 0);
         result : OUT  std_logic_vector(31 downto 0);
         zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');
   signal ctrl : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(31 downto 0);
   signal zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Alu PORT MAP (
          a => a,
          b => b,
          ctrl => ctrl,
          result => result,
          zero => zero
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
			a <= "00110011001100110011001100110011";
			b <= "00011100011100011100011100011100";
		wait for 200 ns;	
			ctrl <= "001";
		wait for 200 ns;
			ctrl <= "111";
		wait for 200 ns;
			ctrl <= "100";
		wait for 200 ns;
			a <= "11111111111111111111111111111001";
			b <= "11111111111111111111111111111000";
		wait for 200 ns;	
			ctrl <= "010";
		wait for 200 ns;
			ctrl <= "110";
		wait for 200 ns;
      wait;
   end process;

END;
