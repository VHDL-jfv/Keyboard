library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Keyboard is
port(
	datak:			in std_logic;
	clock:		in std_logic; --Keyboard clock
   x:				out std_logic_vector(6 downto 0);
	x2:			out std_logic_vector(6 downto 0);
	led:			out std_logic_vector(10 downto 0);
	green:      out std_logic
--	clk:		in std_logic;    --Clock to keep track of time
--	lcd:		out std_logic_vector(7 downto 0);  --LCD data pins
--	enviar : out std_logic;    --Send signal
--	rs:		out std_logic;    --Data or command
--	rw: out std_logic    --read/write
);
end Keyboard;

architecture keyboard of Keyboard is
signal data: unsigned(10 downto 0);
signal data2: unsigned(10 downto 0);
signal count: integer:=0;
--type state_type is (encender, configpantalla,encenderdisplay, limpiardisplay, configcursor,listo,fin);    --Define dfferent states to control the LCD
--signal estado: state_type;
--constant milisegundos: integer := 50000;
--constant microsegundos: integer := 50;

begin
--
--comb_logic: process(clk)
--  variable contar: integer := 0;
--  begin
--	if (clk'event and clk='1') then
--	  case estado is
--	    when encender =>
--		  if (contar < 50*milisegundos) then    --Wait for the LCD to start all its components
--				contar := contar + 1;
--				estado <= encender;
--			else
--				enviar <= '0';
--				contar := 0; 
--				estado <= configpantalla;
--			end if;
--			--From this point we will send diffrent configuration commands as shown in class
--			--You should check the manual to understand what configurations we are sending to
--			--The display. You have to wait between each command for the LCD to take configurations.
--	    when configpantalla =>
--			if (contar = 0) then
--				contar := contar +1;
--				rs <= '0';
--				rw <= '0';
--				lcd <= "00111000";
--				enviar <= '1';
--				estado <= configpantalla;
--			elsif (contar < 1*milisegundos) then
--				contar := contar + 1;
--				estado <= configpantalla;
--			else
--				enviar <= '0';
--				contar := 0;
--				estado <= encenderdisplay;
--			end if;
--	    when encenderdisplay =>
--			if (contar = 0) then
--				contar := contar +1;
--				lcd <= "00001111";				
--				enviar <= '1';
--				estado <= encenderdisplay;
--			elsif (contar < 1*milisegundos) then
--				contar := contar + 1;
--				estado <= encenderdisplay;
--			else
--				enviar <= '0';
--				contar := 0;
--				estado <= limpiardisplay;
--			end if;
--	    when limpiardisplay =>	
--			if (contar = 0) then
--				contar := contar +1;
--				lcd <= "00000001";				
--				enviar <= '1';
--				estado <= limpiardisplay;
--			elsif (contar < 1*milisegundos) then
--				contar := contar + 1;
--				estado <= limpiardisplay;
--			else
--				enviar <= '0';
--				contar := 0;
--				estado <= configcursor;
--			end if;
--	    when configcursor =>	
--			if (contar = 0) then
--				contar := contar +1;
--				lcd <= "00000100";				
--				enviar <= '1';
--				estado <= configcursor;
--			elsif (contar < 1*milisegundos) then
--				contar := contar + 1;
--				estado <= configcursor;
--			else
--				enviar <= '0';
--				contar := 0;
--				estado <= listo;
--			end if;
--			--The display is now configured now it you just can send data to de LCD 
--			--In this example we are just sending letter A, for this project you
--			--Should make it variable for what has been pressed on the keyboard.
--			
--	    when listo =>	
--			if (contar = 0) then
--				rs <= '1';
--				rw <= '0';
--				enviar <= '1';
--				case data(8 downto 1) is
--				    when x"45" => lcd <= x"30"; --0
--                when x"16" => lcd <= x"31"; --1
--                WHEN x"1E" => lcd <= x"32"; --2
--                WHEN x"26" => lcd <= x"33"; --3
--                WHEN x"25" => lcd <= x"34"; --4
--                WHEN x"2E" => lcd <= x"35"; --5
--                WHEN x"36" => lcd <= x"36"; --6
--                WHEN x"3D" => lcd <= x"37"; --7
--                WHEN x"3E" => lcd <= x"38"; --8
--                WHEN x"46" => lcd <= x"39"; --9
--                WHEN x"1C" => lcd <= x"41"; --A
--                WHEN x"32" => lcd <= x"42"; --B
--                WHEN x"21" => lcd <= x"43"; --C
--                WHEN x"23" => lcd <= x"44"; --D
--                WHEN x"24" => lcd <= x"45"; --E
--                WHEN x"2B" => lcd <= x"46"; --F
--                WHEN x"34" => lcd <= x"47"; --G
--                WHEN x"33" => lcd <= x"48"; --H
--                WHEN x"43" => lcd <= x"49"; --I
--                WHEN x"3B" => lcd <= x"4A"; --J
--                WHEN x"42" => lcd <= x"4B"; --K
--                WHEN x"4B" => lcd <= x"4C"; --L
--                WHEN x"3A" => lcd <= x"4D"; --M
--                WHEN x"31" => lcd <= x"4E"; --N
--                WHEN x"44" => lcd <= x"4F"; --O
--                WHEN x"4D" => lcd <= x"50"; --P
--                WHEN x"15" => lcd <= x"51"; --Q
--                WHEN x"2D" => lcd <= x"52"; --R
--                WHEN x"1B" => lcd <= x"53"; --S
--                WHEN x"2C" => lcd <= x"54"; --T
--                WHEN x"3C" => lcd <= x"55"; --U
--                WHEN x"2A" => lcd <= x"56"; --V
--                WHEN x"1D" => lcd <= x"57"; --W
--                WHEN x"22" => lcd <= x"58"; --X
--                WHEN x"35" => lcd <= x"59"; --Y
--                WHEN x"1A" => lcd <= x"5A"; --Z
--                WHEN OTHERS =>
--              end case;
--				contar := contar +1;
--				estado <= listo;
--			elsif (contar < 1*milisegundos) then
--				contar := contar + 1;
--				estado <= listo;
--			else
--				enviar <= '0';
--				contar := 0;
--				estado <= fin;
--			end if;
--		  when fin =>
--			estado <= fin;
--	    when others =>
--			estado <= encender;
--	  end case;
--	end if; 
-- end process;
 process(clock,data,data2,count)
 begin
 	if falling_Edge(clock) and count < 11 then
		if count < 11 then
			data2(count) <= datak;
			count <= count + 1;
		else
			count <= 0;
		end if;
	end if;
	if count = 11 then
		count <= 0;
		data<=data2;
	end if;
	end process;
	process(data,clock)
	begin
    -- Process for the display changes.
--	 	if (clk'event and clk='1') then
--	  case estado is
--	  when listo =>
if data(8 downto 1)= x"F0" then
else
		case data(8 downto 5) is
			when "0000" => x2 <= "0000001"; -- "0" 
		   when "0001" => x2 <= "1001111"; -- "1" 
		   when "0010" => x2 <= "0010010"; -- "2" 
			when "0011" => x2 <= "0000110"; -- "3" 
			when "0100" => x2 <= "1001100"; -- "4" 
			when "0101" => x2 <= "0100100"; -- "5" 
		   when "0110" => x2 <= "0100000"; -- "6"
		   when "0111" => x2 <= "0001111"; -- "7" 
			when "1000" => x2 <= "0000000"; -- "8"   
			when "1001" => x2 <= "0000100"; -- "9" 
			when "1010" => x2 <= "0001000"; -- A
			when "1011" => x2 <= "1100000"; -- b
			when "1100" => x2 <= "0110001"; -- C
			when "1101" => x2 <= "1000010"; -- d
		   when "1110" => x2 <= "0110000"; -- E
		   when "1111" => x2 <= "0111000"; -- F
			when others =>
		end case;
		 case data(4 downto 1) is

		 when "0000" => x <= "0000001"; -- "0" 		 
		 when "0001" => x <= "1001111"; -- "1" 
		 when "0010" => x <= "0010010"; -- "2" 
		 when "0011" => x <= "0000110"; -- "3" 
		 when "0100" => x <= "1001100"; -- "4" 
		 when "0101" => x <= "0100100"; -- "5" 
		 when "0110" => x <= "0100000"; -- "6" 
		 when "0111" => x <= "0001111"; -- "7" 
		 when "1000" => x <= "0000000"; -- "8"     
		 when "1001" => x <= "0000100"; -- "9" 
		 when "1010" => x <= "0001000"; -- A
		 when "1011" => x <= "1100000"; -- b
		 when "1100" => x <= "0110001"; -- C
		 when "1101" => x <= "1000010"; -- d
		 when "1110" => x <= "0110000"; -- E
		 when "1111" => x <= "0111000"; -- F
		 when others =>
		 end case;
		 end if;
--		 when others=>
--		 end case;
--		 end if;
 end process;
end keyboard;