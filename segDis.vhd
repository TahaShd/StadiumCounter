----------------------------------------------------------------------------------
-- Engineer: Lena Krabbe
-- 
-- Create Date: 16.03.2021 09:46:11
-- Design Name: 7-Segment Display
-- Module Name: segDis - Behavioral
-- Project Name: Sports Venue Attendance Counter 

----------------------------------------------------------------------------------

--libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- arithmetic functions with Signed or Unsigned values

entity segDis is
    Port ( attendance : in unsigned(0 to 11);   --12 bits to represent decimal up to 3000
           seg1 : out std_logic_vector(0 to 6); --representing most significant digit
           seg2 : out std_logic_vector(0 to 6);
           seg3 : out std_logic_vector(0 to 6);
           seg4 : out std_logic_vector(0 to 6)); --representing least significant digit
end segDis;

architecture Behavioral of segDis is

    --define segment display elements: a-b-c-d-e-f-g, active high
    constant zero: std_logic_vector := "1111110";
    constant one: std_logic_vector := "0110000";
    constant two: std_logic_vector := "1101101";
    constant three: std_logic_vector := "1111001";
    constant four: std_logic_vector := "0110011";
    constant five: std_logic_vector := "1011011";
    constant six: std_logic_vector := "1011111";
    constant seven: std_logic_vector := "1110000";
    constant eight: std_logic_vector := "1111111";
    constant nine: std_logic_vector := "1111011";   
    
    --define subtype of integer
    subtype intSmall is integer range 0 to 3000;
    
begin
        
    show: process (attendance) is --change in attendance causes process to start
    
    variable att_int: intSmall;   --decimal value of attendance
    variable fac: intSmall;       --factor for modulo operation
    variable noTemp: intSmall;    --one digit of decimal attendance number
    variable dif: intSmall;       --helping variable for calculating noTemp
    
    variable segAll: std_logic_vector(0 to 27); --concatenation of all 4 7-segment displays
        
    begin

        dif := 0;
        fac := 1000; --initial factor modulo and division starting at most significant digit
        att_int := to_integer(attendance); --convert unsigned to integer
        noTemp := 0;
        
        --get single digits of decimal attendance number, starting at most significant digit
        for i in 0 to 3 loop --4 segments
        
            noTemp := (att_int - dif - (att_int mod fac))/fac;
            dif := dif + noTemp*fac;  --refresh dif
            fac := fac/10;            --get factor fac for next digit
            
            --select correct lightning std_logic_vector (defined by constants) and assign it to correct position in segAll
            case noTemp is
                when 0 =>
                segAll(i*7 to ((i*7)+6)) := zero;
                when 1 =>
                segAll(i*7 to ((i*7)+6)) := one; 
                when 2 =>
                segAll(i*7 to ((i*7)+6)) := two; 
                when 3 =>
                segAll(i*7 to ((i*7)+6)) := three; 
                when 4 =>
                segAll(i*7 to ((i*7)+6)) := four; 
                when 5 =>
                segAll(i*7 to ((i*7)+6)) := five; 
                when 6 =>
                segAll(i*7 to ((i*7)+6)) := six; 
                when 7 =>
                segAll(i*7 to ((i*7)+6)) := seven; 
                when 8 =>
                segAll(i*7 to ((i*7)+6)) := eight; 
                when others =>
                segAll(i*7 to i*7+6) := nine;
            end case;
        end loop;
        
        --divide concatenated segAll into 4 7-segment displays (vectors)
        seg1 <= segAll(0 to 6);   --representing most significant digit
        seg2 <= segAll(7 to 13);
        seg3 <= segAll(14 to 20);
        seg4 <= segAll(21 to 27); --representing least significant digit
    end process;


end Behavioral;
