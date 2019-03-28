
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity clock_div is
    port(
        clk  : in std_logic;       -- 125 Mhz clock
        div : out std_logic );
        
end clock_div;

architecture behavior of clock_div is

    signal counter : std_logic_vector(26 downto 0) := (others => '0');

 
     
begin

    process(clk)
    begin
    
        if (rising_edge(clk)) then
                     
            if (unsigned(counter) < 62499999/11529) then
                    counter <= std_logic_vector(unsigned(counter) + 1);
                    div <='0';
            else
                div <='1'; 
                counter <= (others => '0');
                
                    
             end if;    
              
         end if;
    
    end process;
        


end behavior;