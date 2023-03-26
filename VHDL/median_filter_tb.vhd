library std;
use std.textio.all;

library IEEE;
use ieee.std_logic_misc.all;
use ieee.std_logic_textio.all;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity median_filter_tb is
end median_filter_tb;

architecture Behavioral of median_filter_tb is
    component median_filter is
        Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
             clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             median : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal input : std_logic_vector (7 downto 0) := (others => '0');
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';

    signal median : std_logic_vector (7 downto 0);

    constant clk_period : time := 10ns;


begin


    uut : median_filter port map(
            input => input,clk => clk,rst => rst,median => median
        );

    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;


    read_input : process (clk,rst)
        file input_file : text open READ_MODE is "../test.txt";
        variable C : std_logic_vector (7 downto 0);
        variable file_line : line;
    begin
        if(rst = '1') then
        elsif (clk'Event and clk = '1') then
            if not endfile (input_file) then
                readline (input_file,file_line);
                read (file_line,C);
                input <= C;
            else
                input <= (others => '0');
            end if;
        end if;
    end process;

    write_output : process(clk)
        file output_file : text open WRITE_MODE is "../output_data.txt";
        variable C : std_logic_vector (7 downto 0);
        variable file_line : line;
    begin
        if (clk'Event and clk = '1') then
        writeline(output_file,file_line);
        write(file_line,median);
        end if;
    end process;
    
    stim_proc : process
    begin
    rst <= '1';
    wait for 100ns;
    rst <= '0';
    wait for clk_period*10;
    wait;
    end process;
end Behavioral;
