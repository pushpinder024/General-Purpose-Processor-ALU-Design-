library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU1 is
port( Clock : in std_logic; --input clock signal
      A,B : in unsigned(7 downto 0); --8-bit inputs from latches A and B
      student_id : in unsigned(3 downto 0); --4 bit student id from FSM
      OP : in unsigned(15 downto 0); --16-bit selector for Operation from Decoder
      Neg: out std_logic; --is the result negative ? Set-ve bit output
      R1 : out unsigned(3 downto 0); -- lower 4-bits of 8-bit Result Output
      R2 : out unsigned(3 downto 0));  -- higher 4-bits of 8-bit Result Output
end ALU1;

architecture calculation of ALU1 is --temporary signal declarations.
    signal Reg1, Reg2, Result : unsigned(7 downto 0) := (others => '0');
begin

    Reg1 <= A; --temporarily store A in Reg1 local variable
    Reg2 <= B; --temporarily store B in Reg2 local variable

    process(Clock, OP) 
    begin
        if(rising_edge(Clock)) THEN --Do the calculation @ positive edge of clock cycle.
            case OP is
                WHEN "0000000000000001" =>
                    -- Function 1: Addition
                    Result <= Reg1 + Reg2;
                    Neg <= '0';
                    
                WHEN "0000000000000010" =>
                    -- Function 2: Subtraction (A-B)
                    Result <= Reg1 - Reg2;
                    
                    --"Neg" bit set if required.
                    if (Reg1 < Reg2) then
                        Neg <= '1';
                    else
                        Neg <= '0';
                    end if;
                    
                WHEN "0000000000000100" =>
                    -- Function 3: Inverse (NOT A)
                    Result <= not Reg1;
                    Neg <= '0';
                    
                WHEN "0000000000001000" =>
                    -- Function 4: Boolean NAND
                    Result <= Reg1 nand Reg2;
                    Neg <= '0';
                    
                WHEN "0000000000010000" =>
                    -- Function 5: Boolean NOR
                    Result <= Reg1 nor Reg2;
                    Neg <= '0';
                    
                WHEN "0000000000100000" =>
                    -- Function 6: Boolean AND (FIXED)
                    Result <= Reg1 and Reg2;
                    Neg <= '0';
                    
                WHEN "0000000001000000" =>
                    -- Function 7: Boolean XOR (FIXED)
                    Result <= Reg1 xor Reg2;
                    Neg <= '0';
                    
                WHEN "0000000010000000" =>
                    -- Function 8: Boolean OR (FIXED)
                    Result <= Reg1 or Reg2;
                    Neg <= '0';
                    
                WHEN "0000000100000000" =>
                    -- Function 9: Boolean XNOR (FIXED)
                    Result <= Reg1 xnor Reg2;
                    Neg <= '0';
                    
                WHEN OTHERS =>
                    -- Required catch-all: Don't care, output zeroes
                    Result <= (others => '0');
                    Neg <= '0';
                    
            end case;
        end if;
    end process;

    R1 <= Result(3 downto 0);  --Since the output seven segments can
    R2 <= Result(7 downto 4);  -- only 4-bits, split the 8-bit to two 4-bits.

end calculation;