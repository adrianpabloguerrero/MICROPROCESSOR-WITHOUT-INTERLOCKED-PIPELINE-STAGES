--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:41:00 04/16/2013
-- Design Name:   
-- Module Name:   C:/Arqui1GS/mux_muchos/p1C_TB.vhd
-- Project Name:  mux_muchos
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: p1C
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
 
ENTITY p1C_TB IS
END p1C_TB;
 
ARCHITECTURE behavior OF p1C_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT p1C
    PORT(
         d : IN  std_logic_vector(31 downto 0);
         dir : IN  std_logic;
         load : IN  std_logic;
         reset : IN  std_logic;
         clk : IN  std_logic;
         q : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal d : std_logic_vector(31 downto 0) := (others => '0');
   signal dir : std_logic := '0';
   signal load : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal q : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: p1C PORT MAP (
          d => d,
          dir => dir,
          load => load,
          reset => reset,
          clk => clk,
          q => q
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		reset <= '1';
		wait for 10 ns;
		reset <= '0';
		d<=x"12345678";
		dir<='1';
		load<='0';
		wait for 10 ns;
		load<='1';
		wait for 10 ns;
		load<='0'; 
      wait for 10 ns;
		dir<='0';
		wait for 10 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
