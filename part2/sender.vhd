
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sender is
--  Port ( );
port(
    btn, clk, en, rdy, rst : in std_logic;
    char : out std_logic_vector(7 downto 0);
    send : out std_logic);
end sender;

architecture Behavioral of sender is
type state is (idle, busyA, busyB, busyC);
type word is array (0 to 5) of std_logic_vector(7 downto 0);
signal curr : state := idle;
signal i : std_logic_vector(2 downto 0):= "000";
signal NETID : word := (x"61", x"73", x"32", x"37", x"37", x"30");
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                char <= x"00";
                send <= '0';
                i <= "000";
                curr <= idle;
            end if;
            if en = '1' then
            case curr is
                when idle => 
                if rdy = '1' and btn = '1' then
                    if unsigned(i) < 6 then
                        send <= '1';
                        char <= NETID((to_integer(unsigned(i))));
                        i <= std_logic_vector(unsigned(i) +1);
                        curr <= busyA;
                    else
                        i <= "000";
                        curr<= idle;
                    end if;
                end if;
                
                when busyA =>
                    curr <= busyB;
                when busyB =>
                    send <= '0';
                    curr <= busyC;
                when busyC =>
                    if rdy = '1' and btn = '0' then
                        curr <= idle;
                    end if;
             end case;
             end if;
        end if;
    end process;
                        
   
end Behavioral;