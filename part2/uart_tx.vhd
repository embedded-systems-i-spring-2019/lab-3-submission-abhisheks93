
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;

entity uart_tx is
--  Port ( );
port(
    clk, en, send, rst : in std_logic;
    char : in std_logic_vector(7 downto 0);
    ready, tx : out std_logic);
end uart_tx;

architecture Behavioral of uart_tx is
    type state is (idle, start, data);
    signal curr : state := idle;
    signal temp : std_logic_vector(7 downto 0) := (others =>'0'); 
    
begin
    
    process(clk)
    variable counter : natural := 0;
    begin
        if rising_edge(clk) then
            if rst = '1' then
                temp<= "00000000";
                curr<= idle;    
            end if;
            if en = '1' then
            case curr is
            when idle => ready <= '1';
                        tx <= '1';
                        if send = '1' then
                            curr <= start;
                        end if;
            when start => ready <= '0';
                          tx <= '0';
                          temp <= char;
                          counter := 0;
                          
                          curr <= data;
                          
                          
            when data =>  if (counter < 8) then
                            tx<= temp(counter); 
                            counter := counter+1;
                          else
                            tx <= '1';
                            curr<= idle;
                          end if;
            end case;
            end if;
        end if;
    end process;
end Behavioral;