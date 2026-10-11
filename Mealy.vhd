LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Mealy IS
PORT (
    clk           : IN STD_LOGIC;                    -- The clock, controls when state changes
    data_in       : IN STD_LOGIC;                    -- The switch, controls if we jump to the next state
    reset         : IN STD_LOGIC;                    -- Active-LOW reset back to S0
    student_id    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);-- 4-bit output for student ID digit
    current_state : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- 4-bit output for the room number (state)
);
END ENTITY;

ARCHITECTURE fsm OF Mealy IS
    -- Build an enumerated type with 9 states for the state machine
    TYPE state_type IS (s0, s1, s2, s3, s4, s5, s6, s7, s8);
    
    -- Register to hold the current state
    SIGNAL yfsm : state_type;
BEGIN

    -- ==========================================
    -- PROCESS 1: STATE TRANSITIONS (SYNCHRONOUS)
    -- ==========================================
    PROCESS (clk, reset)
    BEGIN
        -- Active LOW reset
        IF reset = '0' THEN
            yfsm <= s0;
            
        -- Trigger on the rising edge of the clock
        ELSIF rising_edge(clk) THEN
            CASE yfsm IS
                WHEN s0 =>
                    IF data_in = '1' THEN yfsm <= s4; ELSE yfsm <= s0; END IF;
                WHEN s1 =>
                    IF data_in = '1' THEN yfsm <= s8; ELSE yfsm <= s1; END IF;
                WHEN s2 =>
                    IF data_in = '1' THEN yfsm <= s7; ELSE yfsm <= s2; END IF;
                WHEN s3 =>
                    IF data_in = '1' THEN yfsm <= s6; ELSE yfsm <= s3; END IF;
                WHEN s4 =>
                    IF data_in = '1' THEN yfsm <= s5; ELSE yfsm <= s4; END IF;
                WHEN s5 =>
                    IF data_in = '1' THEN yfsm <= s3; ELSE yfsm <= s5; END IF;
                WHEN s6 =>
                    IF data_in = '1' THEN yfsm <= s2; ELSE yfsm <= s6; END IF;
                WHEN s7 =>
                    IF data_in = '1' THEN yfsm <= s1; ELSE yfsm <= s7; END IF;
                WHEN s8 =>
                    IF data_in = '1' THEN yfsm <= s0; ELSE yfsm <= s8; END IF;
                WHEN OTHERS =>
                    yfsm <= s0;
            END CASE;
        END IF;
    END PROCESS;

    -- ==========================================
    -- PROCESS 2: MEALY OUTPUT LOGIC (COMBINATIONAL)
    -- ==========================================
    PROCESS (yfsm, data_in)
    BEGIN
        -- Default assignments to prevent latches
        current_state <= (OTHERS => '0');
        student_id    <= (OTHERS => '0');

        CASE yfsm IS
            -- S0 (1st Stop) -> Current: 5, Next: 0
            WHEN s0 =>
                current_state <= "0000";
                IF data_in = '1' THEN
                    student_id <= "0000"; -- Jumping to S4, output 0
                ELSE
                    student_id <= "0101"; -- Staying in S0, output 5
                END IF;

            -- S1 (8th Stop) -> Current: 8, Next: 6
            WHEN s1 =>
                current_state <= "0001";
                IF data_in = '1' THEN
                    student_id <= "0110"; -- Jumping to S8, output 6
                ELSE
                    student_id <= "1000"; -- Staying in S1, output 8
                END IF;

            -- S2 (6th Stop) -> Current: 4, Next: 9
            WHEN s2 =>
                current_state <= "0010";
                IF data_in = '1' THEN
                    student_id <= "1001"; -- Jumping to S7, output 9
                ELSE
                    student_id <= "0100"; -- Staying in S2, output 4
                END IF;

            -- S3 (4th Stop) -> Current: 2, Next: 9
            WHEN s3 =>
                current_state <= "0011";
                IF data_in = '1' THEN
                    student_id <= "1001"; -- Jumping to S6, output 9
                ELSE
                    student_id <= "0010"; -- Staying in S3, output 2
                END IF;

            -- S4 (2nd Stop) -> Current: 0, Next: 1
            WHEN s4 =>
                current_state <= "0100";
                IF data_in = '1' THEN
                    student_id <= "0001"; -- Jumping to S5, output 1
                ELSE
                    student_id <= "0000"; -- Staying in S4, output 0
                END IF;

            -- S5 (3rd Stop) -> Current: 1, Next: 2
            WHEN s5 =>
                current_state <= "0101";
                IF data_in = '1' THEN
                    student_id <= "0010"; -- Jumping to S3, output 2
                ELSE
                    student_id <= "0001"; -- Staying in S5, output 1
                END IF;

            -- S6 (5th Stop) -> Current: 9, Next: 4
            WHEN s6 =>
                current_state <= "0110";
                IF data_in = '1' THEN
                    student_id <= "0100"; -- Jumping to S2, output 4
                ELSE
                    student_id <= "1001"; -- Staying in S6, output 9
                END IF;

            -- S7 (7th Stop) -> Current: 9, Next: 8
            WHEN s7 =>
                current_state <= "0111";
                IF data_in = '1' THEN
                    student_id <= "1000"; -- Jumping to S1, output 8
                ELSE
                    student_id <= "1001"; -- Staying in S7, output 9
                END IF;

            -- S8 (9th Stop) -> Current: 6, Next: 5
            WHEN s8 =>
                current_state <= "1000";
                IF data_in = '1' THEN
                    student_id <= "0101"; -- Jumping to S0, output 5
                ELSE
                    student_id <= "0110"; -- Staying in S8, output 6
                END IF;

            -- Safety Catch for undefined states
            WHEN OTHERS =>
                current_state <= "1111";
                student_id    <= "1110"; -- Output 'E' for Error
        END CASE;
    END PROCESS;
END ARCHITECTURE;