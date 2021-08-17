----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2021 11:33:21
-- Design Name: 
-- Module Name: counter_8bit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_8bit is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Enable : in STD_LOGIC;
           Load : in STD_LOGIC;
           UpDn : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR(7 downto 0);
           Q : out STD_LOGIC_VECTOR(7 downto 0));
end counter_8bit;

architecture Behavioral of counter_8bit is

begin
    counter_func:process(CLK,Reset)
    variable REG : unsigned(7 downto 0) :="00000000";
    begin
        if Reset='1' then
            REG:="00000000";  -- if reset is equal to 1 then REG gets set to 0 
        
        elsif Reset='0' then  -- if reset is not high then this if statement is enabled
            if rising_edge(CLK)then --the following steps only occur synchronously
                if Enable ='1' then  -- if enable is 1 then the clock is enable so stuff gets done
                    
                    if Load ='1' then  -- if load is high then REG becomes the data input
                        REG:=unsigned(Data); 
                    
                    elsif Load ='0' then  -- if load is not high then this if statement is used 
                        if UpDn = '1' then -- if updn is high then the counter should count up 
                            REG:=REG +1;
                            
                        elsif UpDn = '0' then -- if updn is low then the counter should count down 
                            REG:=REG-1;  
                        
                        end if;
                    end if;    --ending load =''
                
                elsif Enable = '0' then  -- if enable =0 then reg should just equal itself
                    REG:=REG;
                
                end if; --ending enable equal to something statement
                
           end if; -- ending the rising edge if statement 
           
         end if; --ending the Reset='' statement
         if REG>"11111110" then
            Reg:="11111110";
            end if;
         Q<=std_logic_vector(REG); -- assigning Q to equal the conversion of REG to std-logic-vector
     
     end process; --ending the process

end Behavioral;
