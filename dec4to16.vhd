LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY dec4to16 IS
    PORT ( w   : IN   STD_LOGIC_VECTOR(3 DOWNTO 0) ; -- 4-bit input
           En  : IN   STD_LOGIC ;                    -- 1-bit enable
           y   : OUT  STD_LOGIC_VECTOR(15 DOWNTO 0) ) ; -- 16-bit output, updated to DOWNTO
END dec4to16 ;

ARCHITECTURE Behavior OF dec4to16 IS
    SIGNAL Enw : STD_LOGIC_VECTOR(4 DOWNTO 0) ;      -- 5-bit concatenated signal
BEGIN
    Enw <= En & w ; -- Concatenate Enable bit with the 4 input bits
    WITH Enw SELECT
        y <= "0000000000000001" WHEN "10000", -- En=1, w=0000 -> Activates y(0)
             "0000000000000010" WHEN "10001", -- En=1, w=0001 -> Activates y(1)
             "0000000000000100" WHEN "10010", -- En=1, w=0010 -> Activates y(2)
             "0000000000001000" WHEN "10011", -- En=1, w=0011 -> Activates y(3)
             "0000000000010000" WHEN "10100", -- En=1, w=0100 -> Activates y(4)
             "0000000000100000" WHEN "10101", -- En=1, w=0101 -> Activates y(5)
             "0000000001000000" WHEN "10110", -- En=1, w=0110 -> Activates y(6)
             "0000000010000000" WHEN "10111", -- En=1, w=0111 -> Activates y(7)
             "0000000100000000" WHEN "11000", -- En=1, w=1000 -> Activates y(8)
             "0000001000000000" WHEN "11001", -- En=1, w=1001 -> Activates y(9)
             "0000010000000000" WHEN "11010", -- En=1, w=1010 -> Activates y(10)
             "0000100000000000" WHEN "11011", -- En=1, w=1011 -> Activates y(11)
             "0001000000000000" WHEN "11100", -- En=1, w=1100 -> Activates y(12)
             "0010000000000000" WHEN "11101", -- En=1, w=1101 -> Activates y(13)
             "0100000000000000" WHEN "11110", -- En=1, w=1110 -> Activates y(14)
             "1000000000000000" WHEN "11111", -- En=1, w=1111 -> Activates y(15)
             "0000000000000000" WHEN OTHERS ; -- When En=0, all outputs are 0
END Behavior ;