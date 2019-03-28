----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2019 07:19:27 AM
-- Design Name: 
-- Module Name: uart_top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_top is
--  Port ( );
port(
    clk : in std_logic;
    btn : in std_logic_vector(1 downto 0);
    TXD : in std_logic;
    RXD : out std_logic);
end uart_top;

architecture Behavioral of uart_top is
component uart
 port (

   clk, en, send, rx, rst      : in std_logic;
   charSend                    : in std_logic_vector (7 downto 0);
   ready, tx, newChar          : out std_logic;
   charRec                     : out std_logic_vector (7 downto 0)

);
end component;

component debounce
port(
    clk     : in  std_logic;  
    btn  : in  std_logic;  
    dbnc  : out std_logic);
end component;


component clock_div
port(
        clk  : in std_logic;       -- 125 Mhz clock
        div : out std_logic );
end component;

component sender
port(
    btn, clk, en, rdy, rst : in std_logic;
    char : out std_logic_vector(7 downto 0);
    send : out std_logic);
end component;

signal div, reset, btn1, rdy, send : std_logic;
signal char : std_logic_vector(7 downto 0);

begin

clockdiv : clock_div
    port map(clk =>clk,
            div => div 
    );

dbnc1 : debounce
port map(clk => clk,
        btn => btn(0),
        dbnc => reset

);

dbnc2 : debounce
port map(clk => clk,
        btn => btn(1),
        dbnc => btn1

);

send1 : sender
port map(btn=> btn1,
        clk => clk,
        en => div,
        rdy => rdy,
        rst => reset,
        send => send,
        char => char);

uart1 : uart
port map(clk => clk,
        en => div,
        send => send,
        rx => TXD,
        rst => reset,
        charsend => char,
        ready => rdy,
        tx => RXD
        
);
 

end Behavioral;