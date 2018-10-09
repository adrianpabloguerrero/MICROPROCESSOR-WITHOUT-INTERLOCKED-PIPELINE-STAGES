library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity processor is
port(
	Clk         : in  std_logic;
	Reset       : in  std_logic;
	-- Instruction memory
	I_Addr      : out std_logic_vector(31 downto 0);
	I_RdStb     : out std_logic;
	I_WrStb     : out std_logic;
	I_DataOut   : out std_logic_vector(31 downto 0);
	I_DataIn    : in  std_logic_vector(31 downto 0);
	-- Data memory
	D_Addr      : out std_logic_vector(31 downto 0);
	D_RdStb     : out std_logic;
	D_WrStb     : out std_logic;
	D_DataOut   : out std_logic_vector(31 downto 0);
	D_DataIn    : in  std_logic_vector(31 downto 0)
);
end processor;


architecture processor_arq of processor is

	-- PERTENECE A ETAPA IF
	signal IF_PC_IN : std_logic_vector(31 downto 0);
	signal IF_PC_OUT : std_logic_vector(31 downto 0);
	signal IF_PC_OUT4 : std_logic_vector(31 downto 0);
	signal IF_INSTRUCTION : std_logic_vector(31 downto 0);
	
	-- REGISTRO IF/ID
	signal IFID_PC_OUT4 : std_logic_vector(31 downto 0);
	signal IFID_INSTRUCTION : std_logic_vector(31 downto 0);

	-- PERTENECE A ETAPA ID
	signal ID_MUX_DATA2_TO_ALU : std_logic;
	signal ID_MUX_REG_DEST : std_logic;
	signal ID_MUX_DATA_TO_REG: std_logic;
	signal ID_REG_WRITE : std_logic;
	signal ID_MEM_READ : std_logic;
	signal ID_MEM_WRITE : std_logic;
	signal ID_IS_BRANCH : std_logic;
	signal ID_PC_OUT4 : std_logic_vector(31 downto 0);
	signal ID_INSTRUCTION : std_logic_vector(31 downto 0);
	signal ID_DATA_RS : std_logic_vector(31 downto 0);
	signal ID_DATA_RT : std_logic_vector(31 downto 0);
	signal ID_SIGN_EXTEND : std_logic_vector(31 downto 0);
	signal ID_ALU_OP : std_logic_vector(1 downto 0);
	signal ID_RS : std_logic_vector(4 downto 0);
	signal ID_RT : std_logic_vector(4 downto 0);
	signal ID_RD : std_logic_vector(4 downto 0);
	signal ID_MUX_ALU_RESULT : std_logic;
	signal ID_MUX_REG_DEST_JAL : std_logic;
	signal ID_MUX_PC_JAL : std_logic;
	signal ID_MUX_PC_JR : std_logic;
	signal ID_DIR_JAL : std_logic_vector (31 downto 0);
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
	
	--REGISTRO ID/EX
	signal IDEX_MUX_DATA2_TO_ALU : std_logic;
	signal IDEX_MUX_REG_DEST : std_logic;
	signal IDEX_MUX_DATA_TO_REG: std_logic;
	signal IDEX_REG_WRITE : std_logic;
	signal IDEX_MEM_READ : std_logic;
	signal IDEX_MEM_WRITE : std_logic;
	signal IDEX_IS_BRANCH : std_logic;
	signal IDEX_ALU_OP : std_logic_vector(1 downto 0);
	signal IDEX_DATA_RS : std_logic_vector(31 downto 0);
	signal IDEX_DATA_RT : std_logic_vector(31 downto 0);
	signal IDEX_SIGN_EXTEND : std_logic_vector(31 downto 0);
	signal IDEX_PC_OUT4 : std_logic_vector(31 downto 0);
	signal IDEX_INSTRUCTION : std_logic_vector(31 downto 0);
	signal IDEX_RT : std_logic_vector(4 downto 0);
	signal IDEX_RD : std_logic_vector(4 downto 0);
	signal IDEX_MUX_ALU_RESULT : std_logic;
	signal IDEX_MUX_REG_DEST_JAL : std_logic;
	signal IDEX_DIR_JAL : std_logic_vector (31 downto 0);

	
	-- PERTENECE A ETAPA EX
	signal EX_MUX_DATA2_TO_ALU : std_logic; 
	signal EX_ALU_OP : std_logic_vector(1 downto 0);
	signal EX_MUX_REG_DEST : std_logic;
	signal EX_IS_BRANCH : std_logic;
	signal EX_MEM_WRITE : std_logic;
	signal EX_MEM_READ : std_logic;
	signal EX_MUX_DATA_TO_REG : std_logic;
	signal EX_REG_WRITE : std_logic;
	signal EX_PC_OUT4 : std_logic_vector(31 downto 0);
	signal EX_DATA_RS : std_logic_vector(31 downto 0);
	signal EX_DATA_RT : std_logic_vector(31 downto 0);
	signal EX_SIGN_EXTEND : std_logic_vector(31 downto 0);
	signal EX_RT : std_logic_vector(4 downto 0);
	signal EX_RD : std_logic_vector(4 downto 0);
	signal EX_ALU_DATA1 : std_logic_vector(31 downto 0);
	signal EX_ALU_DATA2 : std_logic_vector(31 downto 0);
	signal EX_SIGN_EXTEND_4 : std_logic_vector(31 downto 0);
	signal EX_DIR_BRANCH : std_logic_vector(31 downto 0);
	signal EX_ALU_CTRL : std_logic_vector(2 downto 0);
   signal EX_ALU_RESULT : std_logic_vector(31 downto 0);
   signal EX_ZERO : std_logic;
	signal EX_REG_DEST : std_logic_vector (4 downto 0);
	SIGNAL EX_ALU_RESULT1 : std_logic_vector(31 downto 0);
	signal EX_DIR_WRITE_JAL : std_logic_vector(31 downto 0);
	signal EX_MUX_ALU_RESULT : std_logic;
	signal EX_MUX_REG_DEST_JAL : std_logic;
	signal EX_REG_DEST_PARCIAL : std_logic_vector (4 downto 0);
	signal EX_DIR_JAL : std_logic_vector (31 downto 0);

	COMPONENT Alu
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		ctrl : IN std_logic_vector(2 downto 0);          
		result : OUT std_logic_vector(31 downto 0);
		zero : OUT std_logic
		);
	END COMPONENT;
	
	-- REGISTRO EX/MEM
	signal EXMEM_ZERO : std_logic;
	signal EXMEM_REG_DEST : std_logic_vector(4 downto 0);
	signal EXMEM_ALU_RESULT : std_logic_vector(31 downto 0);
	signal EXMEM_DATA_RT : std_logic_vector(31 downto 0);
	signal EXMEM_DIR_BRANCH : std_logic_vector(31 downto 0);
	signal EXMEM_MEM_READ : std_logic;
	signal EXMEM_MEM_WRITE : std_logic;
	signal EXMEM_IS_BRANCH : std_logic;
	signal EXMEM_MUX_DATA_TO_REG : std_logic;
	signal EXMEM_REG_WRITE : std_logic;

	-- PERTENECE A ETAPA MEM
	signal MEM_ZERO : std_logic;
	signal MEM_REG_DEST : std_logic_vector(4 downto 0);
	signal MEM_ALU_RESULT : std_logic_vector(31 downto 0);
	signal MEM_DATA_TO_MEM_WRITE : std_logic_vector(31 downto 0);
	signal MEM_DIR_BRANCH : std_logic_vector(31 downto 0);
	signal MEM_MEM_READ : std_logic;
	signal MEM_MEM_WRITE : std_logic;
	signal MEM_IS_BRANCH : std_logic;
	signal MEM_MUX_DATA_TO_REG : std_logic;
	signal MEM_REG_WRITE : std_logic;
	signal MEM_DATA_FROM_MEM_READ : std_logic_vector(31 downto 0);	
	signal MEM_BRANCH_EFFECTIVE : std_logic;
	
	-- REGISTRO MEM/WB
	signal MEMWB_MUX_DATA_TO_REG : std_logic;	
	signal MEMWB_REG_WRITE : std_logic;	
	signal MEMWB_REG_DEST : std_logic_vector(4 downto 0);	
	signal MEMWB_DATA_FROM_MEM_READ : std_logic_vector(31 downto 0);	
	signal MEMWB_ALU_RESULT : std_logic_vector(31 downto 0);	
	
	-- PERTENECE A ETAPA WB
	signal WB_MUX_DATA_TO_REG : std_logic;	
	signal WB_REG_WRITE : std_logic;	
	signal WB_REG_DEST : std_logic_vector(4 downto 0);	
	signal WB_DATA_FROM_MEM_READ : std_logic_vector(31 downto 0);	
	signal WB_ALU_RESULT : std_logic_vector(31 downto 0);
	signal WB_DATA_TO_REG : std_logic_vector(31 downto 0);	
	
begin 
	----------------------------------------
	----------------------------------------
	---------------ETAPA IF-----------------
	
	-- ETAPA PC
	process (Clk, Reset) is
	begin
		if Reset = '1' then
			IF_PC_OUT <= x"00000000";
		elsif rising_edge(clk) then
			IF_PC_OUT <= IF_PC_IN;
		end if;
	end process;
	
	-- SEÑALES DE LA MEMORIA DE INSTRUCCIONES
	
	I_WrStb <= '0';
	I_RdStb <= '1';
	I_Addr <= IF_PC_OUT;
	I_DataOut <= X"00000000";
	IF_INSTRUCTION <= I_DataIn;

	-- ETAPA INCREMENTAL PC
	
	IF_PC_OUT4 <= IF_PC_OUT + "100";
	
	-- ETAPA MUX PC
	
	process (MEM_BRANCH_EFFECTIVE,IF_PC_OUT4, MEM_DIR_BRANCH) is
	begin
		If MEM_BRANCH_EFFECTIVE = '1' then
			IF_PC_IN <= MEM_DIR_BRANCH;
		elsif ID_MUX_PC_JAL = '1' then
			IF_PC_IN <= EX_DIR_JAL;
		elsif ID_MUX_PC_JR = '1' then
			IF_PC_IN <= ID_DATA_RS;
		else
			IF_PC_IN <= IF_PC_OUT4;
		end if;
	end process;
	
	----------------------------------------
	----------------------------------------
	------------REGISTRO IF/ID--------------
	
	process (Clk, Reset) is
	begin
		If Reset = '1' then
			IFID_PC_OUT4 <= X"00000000";
			IFID_INSTRUCTION <= X"00000000";
		elsif rising_edge(Clk) then
			IFID_PC_OUT4 <= IF_PC_OUT4;
			IFID_INSTRUCTION <= IF_INSTRUCTION;
		end if;
	end process;
	
	----------------------------------------
	----------------------------------------
	---------------ETAPA ID------------------
	
	-- LEVANTA EL REGISTRO IF/ID
	ID_INSTRUCTION <= IFID_INSTRUCTION;
	ID_PC_OUT4 <= IFID_PC_OUT4;
	
	-- SIGN_EXTEND
	process (ID_INSTRUCTION) is
	begin
		if ID_INSTRUCTION(15) = '0' then
			ID_SIGN_EXTEND <= X"0000" & ID_INSTRUCTION(15 downto 0);
		else
			ID_SIGN_EXTEND <= X"FFFF" & ID_INSTRUCTION(15 downto 0);
		end if;
	end process;
	
	-- JR
	process (ID_INSTRUCTION) is
	begin
		if ((ID_INSTRUCTION(31 downto 26) = "000000") and (ID_INSTRUCTION(5 downto 0) = "001000")) then
			ID_MUX_PC_JR <= '1';
		else
			ID_MUX_PC_JR <= '0';
		end if;
	end process;
	
	
	-- CONTROL
	process (ID_INSTRUCTION) is
	begin
		case (ID_INSTRUCTION(31 downto 26)) is
			when "000000" => -- REGAREG
				if ID_MUX_PC_JR = '1' then
						ID_MUX_DATA2_TO_ALU <= '0';
						ID_MUX_REG_DEST <= '0';
						ID_MUX_DATA_TO_REG <= '0';
						ID_REG_WRITE <= '0';
						ID_MEM_READ <= '0';
						ID_MEM_WRITE <= '0';
						ID_IS_BRANCH <= '0';
						ID_ALU_OP <= "00";
						ID_MUX_ALU_RESULT <= '0';
						ID_MUX_REG_DEST_JAL <= '0';
						ID_MUX_PC_JAL <= '0';
				else
						ID_MUX_DATA2_TO_ALU <= '0';
						ID_MUX_REG_DEST <= '1';
						ID_MUX_DATA_TO_REG <= '0';
						ID_REG_WRITE <= '1';
						ID_MEM_READ <= '0';
						ID_MEM_WRITE <= '0';
						ID_IS_BRANCH <= '0';
						ID_ALU_OP <= "10";
						ID_MUX_ALU_RESULT <= '0';
						ID_MUX_REG_DEST_JAL <= '0';
						ID_MUX_PC_JAL <= '0';
				 end if;
			when "100011" => -- LOAD
						ID_MUX_DATA2_TO_ALU <= '1';
						ID_MUX_REG_DEST <= '0';
						ID_MUX_DATA_TO_REG <= '1';
						ID_REG_WRITE <= '1';
						ID_MEM_READ <= '1';
						ID_MEM_WRITE <= '0';
						ID_IS_BRANCH <= '0';
						ID_ALU_OP <= "00";
						ID_MUX_ALU_RESULT <= '0';
						ID_MUX_REG_DEST_JAL <= '0';
						ID_MUX_PC_JAL <= '0';
			when "101011" => -- STORE
						ID_MUX_DATA2_TO_ALU <= '1';
						ID_MUX_REG_DEST <= '0';
						ID_MUX_DATA_TO_REG <= '0';
						ID_REG_WRITE <= '0';
						ID_MEM_READ <= '0';
						ID_MEM_WRITE <= '1';
						ID_IS_BRANCH <= '0';
						ID_ALU_OP <= "00";
						ID_MUX_ALU_RESULT <= '0';
						ID_MUX_REG_DEST_JAL <= '0';
						ID_MUX_PC_JAL <= '0';
			when "000100" => -- SALTO (BEQ)
						ID_MUX_DATA2_TO_ALU <= '0';
						ID_MUX_REG_DEST <= '0';
						ID_MUX_DATA_TO_REG <= '0';
						ID_REG_WRITE <= '0';
						ID_MEM_READ <= '0';
						ID_MEM_WRITE <= '0';
						ID_IS_BRANCH <= '1';
						ID_ALU_OP <= "01";
						ID_MUX_ALU_RESULT <= '0';
						ID_MUX_REG_DEST_JAL <= '0';
						ID_MUX_PC_JAL <= '0';
			when "001111" => -- LUI
						ID_MUX_DATA2_TO_ALU <= '1';
						ID_MUX_REG_DEST <= '0';
						ID_MUX_DATA_TO_REG <= '0';
						ID_REG_WRITE <= '1';
						ID_MEM_READ <= '0';
						ID_MEM_WRITE <= '0';
						ID_IS_BRANCH <= '0';
						ID_ALU_OP <= "00";
						ID_MUX_ALU_RESULT <= '0';
						ID_MUX_REG_DEST_JAL <= '0';
						ID_MUX_PC_JAL <= '0';
			when "000011" => -- JAL
						ID_MUX_DATA2_TO_ALU <= '0';
						ID_MUX_REG_DEST <= '0';
						ID_MUX_DATA_TO_REG <= '0';
						ID_REG_WRITE <= '1';
						ID_MEM_READ <= '0';
						ID_MEM_WRITE <= '0';
						ID_IS_BRANCH <= '0';
						ID_ALU_OP <= "10";
						ID_MUX_ALU_RESULT <= '1';
						ID_MUX_REG_DEST_JAL <= '1';
						ID_MUX_PC_JAL <= '1';
			when others => 
						ID_MUX_DATA2_TO_ALU <= '0';
						ID_MUX_REG_DEST <= '0';
						ID_MUX_DATA_TO_REG <= '0';
						ID_REG_WRITE <= '0';
						ID_MEM_READ <= '0';
						ID_MEM_WRITE <= '0';
						ID_IS_BRANCH <= '0';
						ID_ALU_OP <= "00";
						ID_MUX_ALU_RESULT <= '0';
						ID_MUX_REG_DEST_JAL <= '0';
						ID_MUX_PC_JAL <= '0';
		end case;
	end process;	

	-- JAL
	ID_DIR_JAL <= ID_PC_OUT4 (31 downto 28) & ID_INSTRUCTION (25 downto 0) & "00";

	
	-- IDENTIFICACION DE REGISTROS
	ID_RS <= ID_INSTRUCTION(25 downto 21);
	ID_RT <= ID_INSTRUCTION(20 downto 16);
	ID_RD <= ID_INSTRUCTION(15 downto 11);
	
	-- BANCO DE REGISTROS
	Inst_Banco_de_Registros: Banco_de_Registros PORT MAP(
		reg1_rd => ID_RS,
		reg2_rd => ID_RT,
		reg_wr => WB_REG_DEST,
		data_wr => WB_DATA_TO_REG,
		wr => WB_REG_WRITE,
		reset => Reset,
		clk => Clk,
		data1_rd => ID_DATA_RS,
		data2_rd => ID_DATA_RT
	);
	
	----------------------------------------
	----------------------------------------
	------------REGISTRO ID/EX--------------
	
	process (Clk) is
	begin
		If Reset = '1' then
			IDEX_MUX_DATA2_TO_ALU <= '0';
			IDEX_ALU_OP <= "00";
			IDEX_MUX_REG_DEST <= '0';
			IDEX_IS_BRANCH <= '0';
			IDEX_MEM_WRITE <= '0';
			IDEX_MEM_READ <= '0';
			IDEX_MUX_DATA_TO_REG <= '0';
			IDEX_REG_WRITE <= '0';
			IDEX_PC_OUT4 <= X"00000000";
			IDEX_DATA_RS <= X"00000000";
			IDEX_DATA_RT <= X"00000000";
			IDEX_SIGN_EXTEND <= X"00000000";
			IDEX_RT <= "00000";
			IDEX_RD <= "00000";
			IDEX_MUX_ALU_RESULT <= '0';
			IDEX_MUX_REG_DEST_JAL <= '0';
			IDEX_DIR_JAL <= X"00000000";
		elsif rising_edge(Clk) then
			IDEX_MUX_DATA2_TO_ALU <= ID_MUX_DATA2_TO_ALU;
			IDEX_ALU_OP <= ID_ALU_OP;
			IDEX_MUX_REG_DEST <= ID_MUX_REG_DEST;
			IDEX_IS_BRANCH <= ID_IS_BRANCH;
			IDEX_MEM_WRITE <= ID_MEM_WRITE;
			IDEX_MEM_READ <= ID_MEM_READ;
			IDEX_MUX_DATA_TO_REG <= ID_MUX_DATA_TO_REG;
			IDEX_REG_WRITE <= ID_REG_WRITE;
			IDEX_PC_OUT4 <= ID_PC_OUT4;
			IDEX_DATA_RS <= ID_DATA_RS;
			IDEX_DATA_RT <= ID_DATA_RT;
			IDEX_SIGN_EXTEND <= ID_SIGN_EXTEND;
			IDEX_RT <= ID_RT;
			IDEX_RD <= ID_RD;
			IDEX_MUX_REG_DEST_JAL <= ID_MUX_REG_DEST_JAL;
			IDEX_MUX_ALU_RESULT <= ID_MUX_ALU_RESULT;
			IDEX_DIR_JAL <= ID_DIR_JAL;
		end if;
	end process;
	
	
	----------------------------------------
	----------------------------------------
	---------------ETAPA EX-----------------
	
	
	-- LEVANTA EL REGISTRO ID/EX
	EX_MUX_DATA2_TO_ALU <= IDEX_MUX_DATA2_TO_ALU;
	EX_ALU_OP <= IDEX_ALU_OP;
	EX_MUX_REG_DEST <= IDEX_MUX_REG_DEST;
	EX_IS_BRANCH <= IDEX_IS_BRANCH;
	EX_MEM_WRITE <= IDEX_MEM_WRITE;
	EX_MEM_READ <= IDEX_MEM_READ;
	EX_MUX_DATA_TO_REG <= IDEX_MUX_DATA_TO_REG;
	EX_REG_WRITE <= IDEX_REG_WRITE;
	EX_PC_OUT4 <= IDEX_PC_OUT4;
	EX_DATA_RS <= IDEX_DATA_RS;
	EX_DATA_RT <= IDEX_DATA_RT;
	EX_SIGN_EXTEND <= IDEX_SIGN_EXTEND;
	EX_RT <= IDEX_RT;
	EX_RD <= IDEX_RD;
	EX_MUX_ALU_RESULT <= IDEX_MUX_ALU_RESULT;
	EX_MUX_REG_DEST_JAL <= IDEX_MUX_REG_DEST_JAL;
	EX_DIR_JAL <= IDEX_DIR_JAL;
	
	-- MUX REG DESTINO
	
	EX_REG_DEST_PARCIAL <= EX_RT when EX_MUX_REG_DEST = '0' else
					EX_RD;
					
	EX_REG_DEST <= EX_REG_DEST_PARCIAL when EX_MUX_REG_DEST_JAL = '0' else
						"11111";
	
	
	-- OPERANDOS DE LA ALU
	
	EX_ALU_DATA1 <= EX_DATA_RS;
	EX_ALU_DATA2 <= EX_DATA_RT when EX_MUX_DATA2_TO_ALU = '0' else
					 EX_SIGN_EXTEND;
						 
	-- SIGN_EXTEND + 4
	
	EX_SIGN_EXTEND_4 <= EX_SIGN_EXTEND(29 downto 0) & "00";
	
	-- DIRECCION DEL BRANCH

	EX_DIR_BRANCH <= (EX_PC_OUT4 + EX_SIGN_EXTEND_4);
	
	-- ALU INTANCIACION
	uut: Alu PORT MAP (
          a => EX_ALU_DATA1,
          b => EX_ALU_DATA2,
          ctrl => EX_ALU_CTRL,
          result => EX_ALU_RESULT1,
          zero => EX_ZERO
        );
		  
	-- JAL
	
	EX_DIR_WRITE_JAL <= EX_PC_OUT4 + X"00000008";
	
	EX_ALU_RESULT <= EX_ALU_RESULT1 when EX_MUX_ALU_RESULT = '0' else
					 EX_DIR_WRITE_JAL;
	
	
	-- ALU CONTROL
	
	process (EX_ALU_OP, EX_SIGN_EXTEND) is
	begin
		if EX_ALU_OP = "00" then
			EX_ALU_CTRL <= "010";
		elsif EX_ALU_OP = "01" then
			EX_ALU_CTRL <= "110";
		else
			case (EX_SIGN_EXTEND(5 downto 0)) is
					when "100000" => EX_ALU_CTRL <= "010";
					when "100010" => EX_ALU_CTRL <= "110";
					when "100100" => EX_ALU_CTRL <= "000";
					when "100101" => EX_ALU_CTRL <= "001";
					when "101010" => EX_ALU_CTRL <= "111";
					when others => EX_ALU_CTRL <= "000";
			end case;
		end if;
	end process;
	
	----------------------------------------
	----------------------------------------
	-----------REGISTRO EX/MEM-------------- 

	process (Clk) is
	begin
		If Reset = '1' then
			EXMEM_ZERO <= '0';
			EXMEM_REG_DEST <= "00000";
			EXMEM_ALU_RESULT <= X"00000000";
			EXMEM_DATA_RT <= X"00000000";
			EXMEM_DIR_BRANCH <= X"00000000";
			EXMEM_MEM_READ <= '0';
			EXMEM_MEM_WRITE <= '0';
			EXMEM_IS_BRANCH <= '0';
			EXMEM_MUX_DATA_TO_REG <=  '0';
			EXMEM_REG_WRITE <=  '0';
		elsif rising_edge(Clk) then
			EXMEM_ZERO <= EX_ZERO;
			EXMEM_REG_DEST <= EX_REG_DEST;
			EXMEM_ALU_RESULT <= EX_ALU_RESULT;
			EXMEM_DATA_RT <= EX_DATA_RT;
			EXMEM_DIR_BRANCH <= EX_DIR_BRANCH;
			EXMEM_MEM_READ <= EX_MEM_READ;
			EXMEM_MEM_WRITE <= EX_MEM_WRITE;
			EXMEM_IS_BRANCH <= EX_IS_BRANCH;
			EXMEM_MUX_DATA_TO_REG <= EX_MUX_DATA_TO_REG;
			EXMEM_REG_WRITE <= EX_REG_WRITE;
		end if;
	end process;
	
	----------------------------------------
	----------------------------------------
	--------------ETAPA MEM-----------------
	
	-- LEVANTA EL REGISTRO EX/MEM
	MEM_ZERO <= EXMEM_ZERO;
	MEM_REG_DEST <= EXMEM_REG_DEST;
	MEM_ALU_RESULT <= EXMEM_ALU_RESULT;
	MEM_DATA_TO_MEM_WRITE <= EXMEM_DATA_RT;
	MEM_DIR_BRANCH <= EXMEM_DIR_BRANCH;
	MEM_MEM_READ <= EXMEM_MEM_READ;
	MEM_MEM_WRITE <= EXMEM_MEM_WRITE;
	MEM_IS_BRANCH <= EXMEM_IS_BRANCH;
	MEM_MUX_DATA_TO_REG <= EXMEM_MUX_DATA_TO_REG;
	MEM_REG_WRITE <= EXMEM_REG_WRITE;
	
	-- SEÑALES DE LA MEMORIA DE DATOS
	
	D_Addr <= MEM_ALU_RESULT;
	D_RdStb <= MEM_MEM_READ;
	D_WrStb <= MEM_MEM_WRITE;
	D_DataOut <= MEM_DATA_TO_MEM_WRITE;
	MEM_DATA_FROM_MEM_READ <= D_DataIn;
	
	-- BRANCH CALCULO DE DECISION
	
	MEM_BRANCH_EFFECTIVE <= MEM_IS_BRANCH and MEM_ZERO;
	
	----------------------------------------
	----------------------------------------
	-----------REGISTRO MEM/WB--------------
	
		process (Clk) is
	begin
		If Reset = '1' then
			MEMWB_MUX_DATA_TO_REG <= '0';
			MEMWB_REG_WRITE <= '0';
			MEMWB_REG_DEST <= "00000";
			MEMWB_DATA_FROM_MEM_READ <= X"00000000";
			MEMWB_ALU_RESULT <= X"00000000";
		elsif rising_edge(Clk) then
			MEMWB_MUX_DATA_TO_REG <= MEM_MUX_DATA_TO_REG;
			MEMWB_REG_WRITE <= MEM_REG_WRITE;
			MEMWB_REG_DEST <= MEM_REG_DEST;
			MEMWB_DATA_FROM_MEM_READ <= MEM_DATA_FROM_MEM_READ;
			MEMWB_ALU_RESULT <= MEM_ALU_RESULT;
		end if;
	end process;
	
	----------------------------------------
	----------------------------------------
	---------------ETAPA WB-----------------
	
	-- LEVANTA EL REGISTRO MEM/WB			
	WB_MUX_DATA_TO_REG <= MEMWB_MUX_DATA_TO_REG;
	WB_REG_WRITE <= MEMWB_REG_WRITE;
	WB_REG_DEST <= MEMWB_REG_DEST;
	WB_DATA_FROM_MEM_READ <= MEMWB_DATA_FROM_MEM_READ;
	WB_ALU_RESULT <= MEMWB_ALU_RESULT;
	
	-- MULTIPLEXOR DE DATO A REGISTRO
	
	WB_DATA_TO_REG <= WB_DATA_FROM_MEM_READ when WB_MUX_DATA_TO_REG = '1' else
					  WB_ALU_RESULT;
	

					
end processor_arq;
