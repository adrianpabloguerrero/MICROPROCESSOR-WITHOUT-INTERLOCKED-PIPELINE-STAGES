--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:18:32 04/30/2013
-- Design Name:   
-- Module Name:   E:/Arqui1GS/Practico1/Banco_de_Registros_TB.vhd
-- Project Name:  Practico1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Banco_de_Registros
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
 
ENTITY Banco_de_Registros_TB IS
END Banco_de_Registros_TB;
 
ARCHITECTURE behavior OF Banco_de_Registros_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Banco_de_Registros
    PORT(
         reg1_rd : IN  std_logic_vector(4 downto 0);
         reg2_rd : IN  std_logic_vector(4 downto 0);
         reg_wr : IN  std_logic_vector(4 downto 0);
         data_wr : IN  std_logic_vector(31 downto 0);
         wr : IN  std_logic;
         reset : IN  std_logic;
         clk : IN  std_logic;
         data1_rd : OUT  std_logic_vector(31 downto 0);
         data2_rd : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reg1_rd : std_logic_vector(4 downto 0) := (others => '0');
   signal reg2_rd : std_logic_vector(4 downto 0) := (others => '0');
   signal reg_wr : std_logic_vector(4 downto 0) := (others => '0');
   signal data_wr : std_logic_vector(31 downto 0) := (others => '0');
   signal wr : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal data1_rd : std_logic_vector(31 downto 0);
   signal data2_rd : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Banco_de_Registros PORT MAP (
          reg1_rd => reg1_rd,
          reg2_rd => reg2_rd,
          reg_wr => reg_wr,
          data_wr => data_wr,
          wr => wr,
          reset => reset,
          clk => clk,
          data1_rd => data1_rd,
          data2_rd => data2_rd
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
		reset <= '1';
      wait for 100 ns;
		reset <= '0';
		wr <= '1';
      wait for clk_period*10;
		reg_wr <= "00000";
		data_wr <= X"10000001"; 
		wait for clk_period*10;
		reg_wr <= "00010";
		data_wr <= X"10000002";
		wait for clk_period*10;
		reg_wr <= "10000";
		data_wr <= X"10000003";
		wait for clk_period*10;
		reg1_rd <= "00010";
		reg2_rd <= "10000";
		wait for clk_period*10;
		data_wr <= X"1000000A";
		wait for clk_period*10;
		reset <= '1';
      wait;
   end process;

END;
