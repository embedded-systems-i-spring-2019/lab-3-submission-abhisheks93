

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity debounce is
  generic(
    counter_size  :  INTEGER := 22); 
  port(
    clk     : in  std_logic;  
    btn  : in  std_logic;  
    dbnc  : out std_logic); 
end debounce;

architecture logic OF debounce is
  signal flipflops   : std_logic_vector(1 downto 0); 
  signal counter_set : std_logic;                    
  signal counter_out : std_logic_vector(counter_size downto 0) := (others => '0'); 
begin

  counter_set <= flipflops(0) xor flipflops(1);   
  
  process(clk)
  begin
    if(rising_edge(clk)) then
      flipflops(0) <= btn;
      flipflops(1) <= flipflops(0);
      if(counter_set = '1') then                  
        counter_out <= (others => '0');
      elsif(counter_out(counter_size) = '0') then
        counter_out <= counter_out + 1;
      else                                        
        dbnc <= flipflops(1);
      end if;    
    end if;
  end process;
end logic;