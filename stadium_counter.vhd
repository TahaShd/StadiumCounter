----------------------------------------------------------------------------------
-- Company: STRATHLYDE GROUP 1
-- Engineer: KIERAN FROST
-- 
-- Create Date: 15.03.2021 11:16:23
-- Design Name: STADIUM COUNTER
-- Module Name: stadium_counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity stadium_counter is
    Port ( CLK : in STD_LOGIC;
           Enable : in STD_LOGIC_VECTOR(0 to 11); --enable(0) corresponds to person walking in A etc;
           Reset : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR(0 to 11); --LED(0) corresponds to LED for A;
           total_count : out UNSIGNED(11 downto 0));--total binary count of all people
end stadium_counter;

architecture Behavioral of stadium_counter is

    component counter_8bit 
        port(CLK,Reset,Enable,Load,UpDn: in std_logic;
             Data                      : in std_logic_vector(7 downto 0);
             Q                         :out std_logic_vector(7 downto 0));
    end component;
    
    constant max_seats : integer:=250;--assigned to us in project brief
    constant led_lit : integer:=225; --90% of 250
    
    type storer is array(0 to 11) of std_logic_vector(7 downto 0);
    signal dl : storer; --container to store data from sections

begin
    --generating 12, 8 bit counters corresponding to the 12 different sections
    section_counter_gen: FOR i in 0 to 11 generate
         
         count_elem_gen:counter_8bit
                port map(CLK=>CLK,Reset=>Reset,Enable=>Enable(i),Load=>'0',UpDn=>'1',Data=>dl(i),Q=>dl(i));
     
    end generate;
    
    --dl stores 12 std_logic_vectors for the 12 different areas dl(0) corresponds to A, dl(1) corresponds to B etc.
    
    stad_check:process(dl) --process to check that all are below max seats, if not set to max seats and process executes when dl changes
        variable total_attendance: unsigned(11 downto 0);
        variable temp_init :unsigned (7 downto 0);
        variable temp_resize: unsigned(11 downto 0);
        variable stad_area: storer; --needed to not cause driver error on total_count
     
    begin
        total_attendance:="000000000000";
        temp_init:="00000000";
        temp_resize:="000000000000";
        
        for j in 0 to 11 loop
            if to_integer(unsigned(dl(j)))>max_seats then
                stad_area(j):="11111010"; --so number of seats cannot exceed 250 in each area
            else
                stad_area(j):=dl(j); --else if less that 250 it stays the same
            end if;
            
            temp_init := unsigned(stad_area(j)); --initialising a tempoary variable so that addition can be performed
            temp_resize := resize(temp_init,12); --resizing as the maximum number of seats is 3000 which is a 12 bit unsinged binary number
            total_attendance:=(total_attendance+temp_resize); --this therefore adds every element together to form a variable total_attendance
        end loop;
        total_count<=total_attendance; --mapping total_count to total_attendance
  
    end process;
    
    
    Light:process(dl) -- process to light corresponding LED when over 90% capacity reached in each section, occurs when dl changes
    variable light_check: storer; --needed to not cause driver error on total_coun
    begin
 
        for j in 0 to 11 loop 
            if to_integer(unsigned(dl(j)))>max_seats then
                light_check(j):="11111010"; --so number of seats cannot exceed 250 in each area
            else
                light_check(j):=dl(j); --else if less that 250 it stays the same
            end if;
            
            if to_integer(unsigned(light_check(j)))>led_lit then --if the area is greater than 225, corresponding led lights
                LED(j)<='1';
            elsif to_integer(unsigned(light_check (j)))<led_lit then --else stays unlit
                LED(j)<='0';
            end if;
       end loop;
   end process;

end Behavioral;