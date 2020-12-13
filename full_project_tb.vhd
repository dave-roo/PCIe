library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

Library UNISIM;
use UNISIM.vcomponents.all;

entity full_project_tb is
end full_project_tb;

architecture full_project_tb_arch of full_project_tb is

--components

component full_project is
    port(
    --clock and reset
        CLK_IN_P : in STD_LOGIC ; --100MHZ
        CLK_IN_N : in STD_LOGIC ; --100MHZ
        RST_IN   : in STD_LOGIC ; 
    
	--pcie link
		PCIE_RXN : in STD_LOGIC_VECTOR ( 0 to 0 ); 
		PCIE_RXP : in STD_LOGIC_VECTOR ( 0 to 0 ); 
		PCIE_TXN : out STD_LOGIC_VECTOR ( 0 to 0 ); 
		PCIE_TXP : out STD_LOGIC_VECTOR ( 0 to 0 )
	);	
end component;
        

component Pcie_RP_wrapper is
  port (
    pcie_7x_mgt_0_rxn  : in STD_LOGIC_VECTOR ( 0 to 0 );
    pcie_7x_mgt_0_rxp  : in STD_LOGIC_VECTOR ( 0 to 0 );
    pcie_7x_mgt_0_txn  : out STD_LOGIC_VECTOR ( 0 to 0 );
    pcie_7x_mgt_0_txp  : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tx_0_tdata  : in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tx_0_tkeep  : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tx_0_tlast  : in STD_LOGIC;
    s_axis_tx_0_tready : out STD_LOGIC;
    s_axis_tx_0_tuser  : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tx_0_tvalid : in STD_LOGIC;
    sys_clk_0          : in STD_LOGIC;
    sys_rst_n_0        : in STD_LOGIC;
    user_clk_out_0     : out STD_LOGIC;
    user_reset_out_0   : out STD_LOGIC
  );
end component;
  
    signal CLK_IN_P_sig : STD_LOGIC := '1'; --100MHZ
    signal CLK_IN_N_sig : STD_LOGIC := '0'; --100MHZ
    signal RST_IN_sig   : STD_LOGIC := '0'; 
    
	--pcie link
	signal  PCIE_RXN_sig : STD_LOGIC_VECTOR ( 0 to 0 ); 
	signal  PCIE_RXP_sig : STD_LOGIC_VECTOR ( 0 to 0 ); 
	signal  PCIE_TXN_sig : STD_LOGIC_VECTOR ( 0 to 0 ); 
	signal  PCIE_TXP_sig : STD_LOGIC_VECTOR ( 0 to 0 );


    signal s_axis_tx_0_tdata  : STD_LOGIC_VECTOR ( 63 downto 0 );
    signal s_axis_tx_0_tkeep  : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal s_axis_tx_0_tlast  : STD_LOGIC;
    signal s_axis_tx_0_tready : STD_LOGIC;
    signal s_axis_tx_0_tuser  : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal s_axis_tx_0_tvalid : STD_LOGIC;
    signal user_clk_out_0     : STD_LOGIC;
    signal user_reset_out_0   : STD_LOGIC;
   
    signal counter :std_logic_vector(31 downto 0);


begin


full_project_top: full_project 
    port map(
    --clock and reset
        CLK_IN_P => CLK_IN_P_sig  ,--: in STD_LOGIC := '1'; --100MHZ
        CLK_IN_N => CLK_IN_N_sig  ,--: in STD_LOGIC := '0'; --100MHZ
        RST_IN   => RST_IN_sig    ,--: in STD_LOGIC := '0'; 

	--pcie link  
		PCIE_RXN => PCIE_RXN_sig,--: in STD_LOGIC_VECTOR ( 0 to 0 ); 
		PCIE_RXP => PCIE_RXP_sig,--: in STD_LOGIC_VECTOR ( 0 to 0 ); 
		PCIE_TXN => PCIE_TXN_sig,--: out STD_LOGIC_VECTOR ( 0 to 0 ); 
		PCIE_TXP => PCIE_TXP_sig --: out STD_LOGIC_VECTOR ( 0 to 0 )
		);


Pcie_RP_wrapper_top: Pcie_RP_wrapper
  port map(
    pcie_7x_mgt_0_rxn  => PCIE_TXN_sig,--: in STD_LOGIC_VECTOR ( 0 to 0 );
    pcie_7x_mgt_0_rxp  => PCIE_TXP_sig,--: in STD_LOGIC_VECTOR ( 0 to 0 );
    pcie_7x_mgt_0_txn  => PCIE_RXN_sig,--: out STD_LOGIC_VECTOR ( 0 to 0 );
    pcie_7x_mgt_0_txp  => PCIE_RXP_sig,--: out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axis_tx_0_tdata  => s_axis_tx_0_tdata ,--: in STD_LOGIC_VECTOR ( 63 downto 0 );
    s_axis_tx_0_tkeep  => s_axis_tx_0_tkeep ,--: in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axis_tx_0_tlast  => s_axis_tx_0_tlast ,--: in STD_LOGIC;
    s_axis_tx_0_tready => s_axis_tx_0_tready,--: out STD_LOGIC;
    s_axis_tx_0_tuser  => s_axis_tx_0_tuser ,--: in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axis_tx_0_tvalid => s_axis_tx_0_tvalid,--: in STD_LOGIC;
    sys_clk_0          => CLK_IN_P_sig      ,--: in STD_LOGIC;
    sys_rst_n_0        => RST_IN_sig        ,--: in STD_LOGIC
    user_clk_out_0     => user_clk_out_0    ,--: out STD_LOGIC;
    user_reset_out_0   => user_reset_out_0   --: out STD_LOGIC
  );


RST_IN_sig <= '0', '1' after 4 us;

CLK_IN_P_sig <= not CLK_IN_P_sig after 5 ns;
CLK_IN_N_sig <= not CLK_IN_P_sig;


process (user_clk_out_0,user_reset_out_0)
begin
    if (user_reset_out_0 = '1') then
        s_axis_tx_0_tdata <= x"0000000000000000";
        s_axis_tx_0_tkeep <= x"00";
        s_axis_tx_0_tlast <= '0';
        s_axis_tx_0_tuser <= x"0";
        s_axis_tx_0_tvalid <= '0';
        counter <= x"00000000";
	elsif (rising_edge (user_clk_out_0)) then
        if (s_axis_tx_0_tready = '1') then
		    counter <= counter + '1';
			if (counter  = x"000000C35") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A00F0F";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000C36") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"00000010";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A00010";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';
			
			
			elsif (counter  = x"000000C98") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A0100F";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000C99") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"00000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A00014";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';
			
			
			elsif (counter  = x"000000CFD") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A0110F";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000CFE") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"00000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A00018";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';
			
			elsif (counter  = x"000000D61") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A0120F";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000D62") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"00000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A0001C";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';
			
			elsif (counter  = x"000000DC5") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A0130F";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000DC6") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"00000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A00020";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';

			elsif (counter  = x"000000E29") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A0140F";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000E2A") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"00000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A00024";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';

			elsif (counter  = x"000000E8D") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A0150F";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000E8E") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"00000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A00030";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';

			elsif (counter  = x"000000EF1") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A01601";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000EF2") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"03000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A00004";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';

			elsif (counter  = x"000000F55") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A01701";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"44000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000F56") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"5F000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"01A00068";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';

			elsif (counter  = x"000000FB9") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"01A0020F";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"40000001";
				s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '1';
			elsif (counter  = x"000000FBA") then
			    s_axis_tx_0_tdata(63 downto 32) <= x"04030201";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"10000000";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '1';
			    s_axis_tx_0_tvalid <= '1';

			
			
			
			else
			    s_axis_tx_0_tdata(63 downto 32) <= x"00000000";
			    s_axis_tx_0_tdata(31 downto 0)  <= x"00000000";
			    s_axis_tx_0_tkeep <= x"FF";
			    s_axis_tx_0_tlast <= '0';
			    s_axis_tx_0_tvalid <= '0';	 
			
			
			
			end if;
			
			
			
			
		end if;
	end if;
end process; 









end full_project_tb_arch;