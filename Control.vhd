
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

entity Control is
    Port ( CLK : in STD_LOGIC;-- Clock input for the counter
           Enable : in STD_LOGIC_VECTOR(0 TO 11); -- Enable array for 12 sagments of stadium
           Reset : in STD_LOGIC;-- Reset to set values back to zero after match finishes
           LED : out STD_LOGIC_VECTOR(0 TO 11);-- LED's that shows capacity is more than 90% 
           total_count: inout unsigned(11 downto 0); -- signal to connect from counter to display
           seg1 : out std_logic_vector(0 to 6);--1st display
           seg2 : out std_logic_vector(0 to 6);--2nd display
           seg3 : out std_logic_vector(0 to 6);--3rd display
           seg4 : out std_logic_vector(0 to 6));--4th display
end Control;

architecture Behavioral of Control is

component stadium_counter is
    Port ( CLK : in STD_LOGIC;
           Enable : in STD_LOGIC_VECTOR(0 to 11); 
           Reset : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR(0 to 11); 
           total_count : out UNSIGNED(11 downto 0));
end component;

component segDis is
    Port ( attendance : in unsigned(0 to 11); 
           seg1 : out std_logic_vector(0 to 6);
           seg2 : out std_logic_vector(0 to 6);
           seg3 : out std_logic_vector(0 to 6);
           seg4 : out std_logic_vector(0 to 6));
end component;


begin
--creathing hierarchy for counter 
Attendance: stadium_counter
port map(
        CLK=>CLK,
        Enable=>Enable,
        Reset=>Reset,
        LED=>LED,
        total_count=>total_count);
--creathing hierarchy for counter 
 Display : segDis
 port map(
        attendance=>total_count,
        seg1=>seg1,
        seg2=>seg2,
        seg3=>seg3,
        seg4=>seg4);
 
 
end Behavioral;

