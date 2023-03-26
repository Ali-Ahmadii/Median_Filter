library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sort is
    Port ( in0 : in STD_LOGIC_VECTOR (7 downto 0);
           in1 : in STD_LOGIC_VECTOR (7 downto 0);
           high : out STD_LOGIC_VECTOR (7 downto 0);
           low : out STD_LOGIC_VECTOR (7 downto 0));
end sort;

architecture Behavioral of sort is

begin
high <= in0 when (in0>in1) else in1;
low <= in1 when (in0>in1) else in0;
end Behavioral;
