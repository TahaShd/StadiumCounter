LIBRARY ieee;
LIBRARY generics;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT Control
	PORT(
		CLK : IN std_logic;
		Enable : IN std_logic_vector(0 to 11);
		Reset : IN std_logic;    
		total_count : INOUT unsigned(11 downto 0);      
		LED : OUT std_logic_vector(0 to 11);
		seg1 : OUT std_logic_vector(0 to 6);
		seg2 : OUT std_logic_vector(0 to 6);
		seg3 : OUT std_logic_vector(0 to 6);
		seg4 : OUT std_logic_vector(0 to 6)
		);
	END COMPONENT;

	SIGNAL CLK :  std_logic;
	SIGNAL Enable :  std_logic_vector(0 to 11);
	SIGNAL Reset :  std_logic;
	SIGNAL LED :  std_logic_vector(0 to 11);
	SIGNAL total_count :  unsigned(11 downto 0);
	SIGNAL seg1 :  std_logic_vector(0 to 6);
	SIGNAL seg2 :  std_logic_vector(0 to 6);
	SIGNAL seg3 :  std_logic_vector(0 to 6);
	SIGNAL seg4 :  std_logic_vector(0 to 6);

BEGIN

	uut: Control PORT MAP(
		CLK => CLK,
		Enable => Enable,
		Reset => Reset,
		LED => LED,
		total_count => total_count,
		seg1 => seg1,
		seg2 => seg2,
		seg3 => seg3,
		seg4 => seg4
	);

  Clock: PROCESS
    BEGIN
     CLK<='0';
     for i in 1 to 1000 loop
        wait for 0.5ns;
        CLK<= not CLK;
     END loop;
     wait;
     END PROCESS;
  -- Match scale 1ns=1m  
   tb : PROCESS
   BEGIN
   
   Enable<= "000000000000";
   Reset<= '1';
   --Setting starting values to zero
   wait for 5ns;
   Enable<= "100000000000";
   Reset<= '0';
   wait for 10ns; -- counter before 90m of game
   Enable<= "110000000000";
   wait for 10ns; -- counter before 80m of game
   Enable<= "101000000000";
   wait for 10ns; -- counter before 70m of game
   Enable<= "100010000000";
   wait for 10ns;-- counter  before 60m of game
   Enable<= "100001100010";
   wait for 10ns;-- counter  before 50m of game
   Enable<= "100001100011";
   wait for 10ns;-- counter  before 40m of game
   Enable<= "111001111111";
   wait for 10ns;-- counter  before 30m of game
   Enable<= "111101111111";
   wait for 10ns;-- counter  before 20m of game
   Enable<= "111111111111"; 
   wait for 200ns;-- counter  before 10m of game
   Enable<= "000000000000"; 
   wait for 10ns;-- counter during the game
   Reset<= '1';-- reseting to zero after match ends // counter after the  game
   wait; 
   END PROCESS;


END;