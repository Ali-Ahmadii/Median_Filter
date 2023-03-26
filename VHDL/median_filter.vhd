library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity median_filter is
    Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
         clk : in STD_LOGIC;
         rst : in STD_LOGIC;
         median : out STD_LOGIC_VECTOR (7 downto 0));
end median_filter;

architecture Behavioral of median_filter is
    component sort is
        Port ( in0 : in STD_LOGIC_VECTOR (7 downto 0);
             in1 : in STD_LOGIC_VECTOR (7 downto 0);
             high : out STD_LOGIC_VECTOR (7 downto 0);
             low : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    type std_stage_bit is array (0 to 9) of std_logic_vector (7 downto 0);
    type std_9_9 is array (0 to 9) of std_stage_bit;
    signal a : std_9_9;
    signal b : std_stage_bit;
begin
    process (clk,rst)
    begin
        if rst = '1' then median <= (others => '0');
            b <= (others=>(others => '0'));
        elsif rising_edge(clk) then
            b(0) <= input;
            for i in 0 to 8 loop
                b(i+1) <= b(i);
            end loop;
            median <= a(4)(9);
        end if;
    end process;

    stage : for i in 0 to 9 generate
        a(i)(0) <= b(i);
    end generate;

    even_outer : for i in 0 to 4 generate
        even_inner : for j in 0 to 4 generate
            even : sort port map(
                    in0 => a(2*j)(2*i),
                    in1 => a(2*j+1)(2*i),
                    high => a(2*j)(2*i+1),
                    low => a(2*j+1)(2*i+1)
                );
        end generate;
    end generate;
    
     odd_outer :for i in 0 to 3 generate
        odd_inner: for j in 0 to 3 generate
        odd : sort port map(
        in0 => a(2*j+1)(2*i+1),
        in1 => a(2*j+2)(2*i+1),
        high => a(2*j+1)(2*i+2),
        low =>a(2*j+2)(2*i+2)
        );
        end generate;
        a(0)(2*i+2) <= a(0)(2*i+1);
        a(9)(2*i+2) <= a(9)(2*i+1);
        end generate;
end Behavioral;
