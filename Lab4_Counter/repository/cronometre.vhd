----------------------------------------------------------------------------------
--
--  Practica 5 Sistemes Digitals
--  Cronometre
--
--  L'objectiu d'aquesta practica es fer la descripcio de hardware d'un
--  dispositiu funcioni com a cronometre digital
--
--  Autors: @marcelcases
--          Roger Baiges
--          Marc Sole
--  Creat:  2018.01.17
--  Editat: 2018.01.17
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.port_array_pkge.all;


entity cronometre is
    Port (  -- Font de la senyal (intern)
            clk : in std_logic;
            
            -- Posada a zero (pel reset) (boto)
            reset : in std_logic;
            
            -- Selecciona com s'ha de mostrar el comptatge (MM:SS o SS:CC) (switch)
            escala : in std_logic;
            
            -- Start / Stop (boto)
            start_stop : in std_logic;
            
            -- LAP : podrem visualitzar un temps parcial mentre internament el cronometre va avancant (boto)
            lap , last_lap : in std_logic;
            
            -- Memoria : visualitza l'ultima mesura emmagatzemada (boto)
            memoria : in std_logic;
            
            -- Pantalles 7seg
            cat : out STD_LOGIC_VECTOR (7 downto 0);
            an : out STD_LOGIC_VECTOR (3 downto 0)
            );
end cronometre;

architecture Behavioral of cronometre is
    -- Component *DETECTOR DE FLANC*
    component detector_flanc
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               entrada_bruta : in std_logic;
               sortida_neta : out std_logic
               );
    end component;
    
    -- Component *BIN A BCD*
    component bin_bcd_var is
        Generic (   bin_n : integer := 16;
                    bcds_out_n : integer := 5
                    );
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               fi_conversio : out std_logic;
               inici_conversio : in std_logic;
               bin_in : in STD_LOGIC_VECTOR(bin_n - 1 downto 0);
               bcd_out : out array_bcd(bcds_out_n - 1 downto 0)
               );
    end component;
    
    -- Component *PANTALLES 7SEG*
    component bcd_7seg_var is
        Generic ( num_bcds : integer := 4
                  );
        Port (  clk, reset : in std_logic;
                cat : out STD_LOGIC_VECTOR (7 downto 0);
                an : out STD_LOGIC_VECTOR (3 downto 0);
                bcd : in array_bcd(3 downto 0);
                disp_en : in STD_LOGIC
                );
    end component;
    
    -- Component *DIVISOR CLOCK*
    component divisor_clk is
        generic ( eoc: integer := 1000000
                  );
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               enable : in std_logic;
               clk_div : out STD_LOGIC
               );
    end component;
    
    -- Component *DIVISIO DE LES UNITATS*
    component divisio_unitats is
        Generic (   fi: integer := 10
                    );
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               clk_div : in std_logic;
               fi_de_compte : out std_logic;
               valor_actual : out std_logic_vector (7 downto 0)
               );
    end component;
    
    -- Component *TOGGLE*
    component toggle is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               pols_in : in STD_LOGIC;
               sortida : out STD_LOGIC
               );
    end component;
    
    
    signal clk_div : std_logic; -- Genera un pols cada 10ms (unitat minima)
    signal fi_de_compte_centesimes, fi_de_compte_decimes_de_segon, fi_de_compte_segons, fi_de_compte_desenes_de_segons, fi_de_compte_minuts, fi_de_compte_desenes_de_minuts : std_logic; -- Indica quan cada un dels sis moduls ha acabat de comptar
    signal valor_actual_centesimes, valor_actual_decimes_de_segon, valor_actual_segons, valor_actual_desenes_de_segons, valor_actual_minuts, valor_actual_desenes_de_minuts : std_logic_vector (7 downto 0); -- Indica el valor de cada un dels sis moduls en cada moment
    signal start_stop_net, lap_net : std_logic; -- Senyals filtrades pel detector de flanc
    signal crono_on : std_logic; -- Determina si funciona le cronometre o no
    signal lap_on : std_logic; -- Determina si s'ha de mostrar la memoria del LAP o no
    
    type lap_record_tipus is record -- Record per la memoria del LAP
        desenes_de_minuts, minuts, desenes_de_segons, segons, decimes_de_segon, centesimes : std_logic_vector (7 downto 0);
    end record;
    signal lap_record : lap_record_tipus;
    
    signal bcd : array_bcd(3 downto 0);

begin

-- [1] Divisor de la senyal del rellotge
inst_divisor_clk : divisor_clk
    generic map ( eoc => 1000000
                  )
    port map ( clk => clk,
               reset => reset,
               enable => crono_on,
               clk_div => clk_div
               );


-- [2] Divisio de les unitats de temps
inst_centesimes : divisio_unitats
    generic map (   fi => 9
                    )
    port map ( clk => clk,
               reset => reset,
               clk_div => clk_div,
               fi_de_compte => fi_de_compte_centesimes,
               valor_actual => valor_actual_centesimes
               );
               
inst_decimes_de_segon : divisio_unitats
       generic map (   fi => 9
                        )
       port map ( clk => clk,
                  reset => reset,
                  clk_div => fi_de_compte_centesimes,
                  fi_de_compte => fi_de_compte_decimes_de_segon,
                  valor_actual => valor_actual_decimes_de_segon
                  );

inst_segons : divisio_unitats
    generic map (   fi => 9
                    )
    port map ( clk => clk,
               reset => reset,
               clk_div => fi_de_compte_decimes_de_segon,
               fi_de_compte => fi_de_compte_segons,
               valor_actual => valor_actual_segons
               );

inst_desenes_de_segons : divisio_unitats
    generic map (   fi => 5
                    )
    port map ( clk => clk,
               reset => reset,
               clk_div => fi_de_compte_segons,
               fi_de_compte => fi_de_compte_desenes_de_segons,
               valor_actual => valor_actual_desenes_de_segons
               );

inst_minuts : divisio_unitats
    generic map (   fi => 9
                    )
    port map ( clk => clk,
               reset => reset,
               clk_div => fi_de_compte_desenes_de_segons,
               fi_de_compte => fi_de_compte_minuts,
               valor_actual => valor_actual_minuts
               );

inst_desenes_de_minuts : divisio_unitats
    generic map (   fi => 9
                    )
    port map ( clk => clk,
               reset => reset,
               clk_div => fi_de_compte_minuts,
               fi_de_compte => fi_de_compte_desenes_de_minuts,
               valor_actual => valor_actual_desenes_de_minuts
               );


-- [3] Detectors de flanc
inst_detector_flanc_start_stop : detector_flanc
    port map (  clk => clk,
                reset => reset,
                entrada_bruta => start_stop,
                sortida_neta => start_stop_net
                );

inst_detector_flanc_lap : detector_flanc
    port map (  clk => clk,
                reset => reset,
                entrada_bruta => lap,
                sortida_neta => lap_net
                );                   


-- [4] Funcio Start / Stop
inst_toggle_start_stop : toggle
    port map ( clk => clk,
               reset => reset,
               pols_in => start_stop_net,
               sortida => crono_on
               );


-- [5] Funcio LAP
inst_toggle_lap : toggle
    port map ( clk => clk,
               reset => reset,
               pols_in => lap_net,
               sortida => lap_on
               );

funcio_lap : process (clk, lap_on) begin
    if lap_net = '1' and lap_on = '0' then
        lap_record.desenes_de_minuts <= valor_actual_desenes_de_minuts;
        lap_record.minuts <= valor_actual_minuts;
        lap_record.desenes_de_segons <= valor_actual_desenes_de_segons;
        lap_record.segons <= valor_actual_segons;
        lap_record.decimes_de_segon <= valor_actual_decimes_de_segon;
        lap_record.centesimes <= valor_actual_centesimes;
    end if;
end process;


-- [6] Funcio LAST LAP





-- [7] Mode de visualitzacio      [8] Visualitzacio del temps en els displays
visualitzacio : process (escala) begin
    if escala = '0' then -- MM:SS
        if lap_on = '1' or last_lap = '1' then
            bcd(0) <= lap_record.segons;
            bcd(1) <= lap_record.desenes_de_segons;
            bcd(2) <= lap_record.minuts;
            bcd(3) <= lap_record.desenes_de_minuts;
        else
            bcd(0) <= valor_actual_segons;
            bcd(1) <= valor_actual_desenes_de_segons;
            bcd(2) <= valor_actual_minuts;
            bcd(3) <= valor_actual_desenes_de_minuts;
        end if;
        
    else -- SS:CC
        if lap_on = '1' or last_lap = '1' then
            bcd(0) <= lap_record.centesimes;
            bcd(1) <= lap_record.decimes_de_segon;
            bcd(2) <= lap_record.segons;
            bcd(3) <= lap_record.desenes_de_segons;
        else
            bcd(0) <= valor_actual_centesimes;
            bcd(1) <= valor_actual_decimes_de_segon;
            bcd(2) <= valor_actual_segons;
            bcd(3) <= valor_actual_desenes_de_segons;
        end if;
    end if;
end process;

-- [9] Codificador a 7 segments
inst_bcd_7seg_var : bcd_7seg_var
    generic map (   num_bcds => 4
                    )
    port map ( clk => clk,
               reset => reset,
               bcd => bcd,
               an => an,
               cat => cat,
               disp_en => '1'
               );

-- [10] Ultims retocs
-- Blink dels punts del mig (  :  )


end Behavioral;
