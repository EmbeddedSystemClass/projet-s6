-- Squelette_DSPBuilder_GN.vhd

-- Generated using ACDS version 14.0 200 at 2014.07.10.07:25:36

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Squelette_DSPBuilder_GN is
	port (
		modulateur_bit_a_transmettre : in  std_logic                     := '0'; -- modulateur_bit_a_transmettre.wire
		modulateur_bitclock_i        : in  std_logic                     := '0'; --        modulateur_bitclock_i.wire
		Clock_50MHz                  : in  std_logic                     := '0'; --                  Clock_50MHz.clk
		aclr                         : in  std_logic                     := '0'; --                             .reset_n
		Output_DAC0                  : out std_logic_vector(13 downto 0);        --                  Output_DAC0.wire
		Output_test                  : out std_logic;                            --                  Output_test.wire
		modulateur_bitclock_q        : in  std_logic                     := '0'; --        modulateur_bitclock_q.wire
		Clock_125MHz                 : in  std_logic                     := '0'; --                 Clock_125MHz.clk
		aclr_125                     : in  std_logic                     := '0'; --                             .reset_n
		modulateur_enable            : in  std_logic                     := '0'; --            modulateur_enable.wire
		Clock_62p5MHz                : in  std_logic                     := '0'; --                Clock_62p5MHz.clk
		aclr_62p5                    : in  std_logic                     := '0'; --                             .reset_n
		Clock_2MHz                   : in  std_logic                     := '0'; --                   Clock_2MHz.clk
		aclr_2                       : in  std_logic                     := '0'  --                             .reset_n
	);
end entity Squelette_DSPBuilder_GN;

architecture rtl of Squelette_DSPBuilder_GN is
	component alt_dspbuilder_clock_GNF343OQUJ is
		port (
			aclr      : in  std_logic := 'X'; -- reset
			aclr_n    : in  std_logic := 'X'; -- reset_n
			aclr_out  : out std_logic;        -- reset
			clock     : in  std_logic := 'X'; -- clk
			clock_out : out std_logic         -- clk
		);
	end component alt_dspbuilder_clock_GNF343OQUJ;

	component alt_dspbuilder_port_GN37ALZBS4 is
		port (
			input  : in  std_logic := 'X'; -- wire
			output : out std_logic         -- wire
		);
	end component alt_dspbuilder_port_GN37ALZBS4;

	component alt_dspbuilder_bypass_GNGEVLMN77 is
		generic (
			HDLTYPE : string  := "STD_LOGIC_VECTOR";
			width   : natural := 8
		);
		port (
			input  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_bypass_GNGEVLMN77;

	component alt_dspbuilder_delay_GN6TGYZDFK is
		generic (
			ClockPhase : string   := "1";
			delay      : positive := 1;
			use_init   : natural  := 0;
			BitPattern : string   := "00000001";
			width      : positive := 8
		);
		port (
			aclr   : in  std_logic                          := 'X';             -- clk
			clock  : in  std_logic                          := 'X';             -- clk
			ena    : in  std_logic                          := 'X';             -- wire
			input  : in  std_logic_vector(width-1 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(width-1 downto 0);                    -- wire
			sclr   : in  std_logic                          := 'X'              -- wire
		);
	end component alt_dspbuilder_delay_GN6TGYZDFK;

	component alt_dspbuilder_vcc_GN is
		port (
			output : out std_logic   -- wire
		);
	end component alt_dspbuilder_vcc_GN;

	component alt_dspbuilder_constant_GNR47HMCFS is
		generic (
			HDLTYPE    : string  := "STD_LOGIC_VECTOR";
			BitPattern : string  := "0000";
			width      : natural := 4
		);
		port (
			output : out std_logic_vector(18 downto 0)   -- wire
		);
	end component alt_dspbuilder_constant_GNR47HMCFS;

	component alt_dspbuilder_multiplier_GNVM2FSDDK is
		generic (
			DEDICATED_MULTIPLIER_CIRCUITRY : string  := "AUTO";
			Signed                         : natural := 0;
			OutputMsb                      : integer := 8;
			aWidth                         : natural := 8;
			bWidth                         : natural := 8;
			OutputLsb                      : integer := 0;
			pipeline                       : integer := 0
		);
		port (
			aclr      : in  std_logic                                          := 'X';             -- clk
			clock     : in  std_logic                                          := 'X';             -- clk
			dataa     : in  std_logic_vector(aWidth-1 downto 0)                := (others => 'X'); -- wire
			datab     : in  std_logic_vector(bWidth-1 downto 0)                := (others => 'X'); -- wire
			ena       : in  std_logic                                          := 'X';             -- wire
			result    : out std_logic_vector(OutputMsb-OutputLsb+1-1 downto 0);                    -- wire
			user_aclr : in  std_logic                                          := 'X'              -- wire
		);
	end component alt_dspbuilder_multiplier_GNVM2FSDDK;

	component alt_dspbuilder_gnd_GN is
		port (
			output : out std_logic   -- wire
		);
	end component alt_dspbuilder_gnd_GN;

	component alt_dspbuilder_cast_GN6KYL5EP5 is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(14 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GN6KYL5EP5;

	component alt_dspbuilder_delay_GNQOGXYDHZ is
		generic (
			ClockPhase : string   := "1";
			delay      : positive := 1;
			use_init   : natural  := 0;
			BitPattern : string   := "00000001";
			width      : positive := 8
		);
		port (
			aclr   : in  std_logic                          := 'X';             -- clk
			clock  : in  std_logic                          := 'X';             -- clk
			ena    : in  std_logic                          := 'X';             -- wire
			input  : in  std_logic_vector(width-1 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(width-1 downto 0);                    -- wire
			sclr   : in  std_logic                          := 'X'              -- wire
		);
	end component alt_dspbuilder_delay_GNQOGXYDHZ;

	component alt_dspbuilder_port_GNBOOX3JQY is
		port (
			input  : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_port_GNBOOX3JQY;

	component alt_dspbuilder_parallel_adder_GNGXGUGRPY is
		generic (
			direction     : string   := "+";
			dataWidth     : positive := 8;
			MaskValue     : string   := "1";
			number_inputs : positive := 2;
			pipeline      : natural  := 0
		);
		port (
			clock     : in  std_logic                     := 'X';             -- clk
			aclr      : in  std_logic                     := 'X';             -- reset
			result    : out std_logic_vector(14 downto 0);                    -- wire
			user_aclr : in  std_logic                     := 'X';             -- wire
			ena       : in  std_logic                     := 'X';             -- wire
			data0     : in  std_logic_vector(13 downto 0) := (others => 'X'); -- wire
			data1     : in  std_logic_vector(13 downto 0) := (others => 'X')  -- wire
		);
	end component alt_dspbuilder_parallel_adder_GNGXGUGRPY;

	component alt_dspbuilder_cast_GNVFK2425V is
		generic (
			round    : natural := 0;
			saturate : natural := 0
		);
		port (
			input  : in  std_logic_vector(32 downto 0) := (others => 'X'); -- wire
			output : out std_logic_vector(13 downto 0)                     -- wire
		);
	end component alt_dspbuilder_cast_GNVFK2425V;

	signal delayenavcc_output_wire                                     : std_logic;                     -- DelayenaVCC:output -> Delay:ena
	signal multiplieruser_aclrgnd_output_wire                          : std_logic;                     -- Multiplieruser_aclrGND:output -> Multiplier:user_aclr
	signal multiplierenavcc_output_wire                                : std_logic;                     -- MultiplierenaVCC:output -> Multiplier:ena
	signal delay1enavcc_output_wire                                    : std_logic;                     -- Delay1enaVCC:output -> Delay1:ena
	signal parallel_adder_subtractoruser_aclrgnd_output_wire           : std_logic;                     -- Parallel_Adder_Subtractoruser_aclrGND:output -> Parallel_Adder_Subtractor:user_aclr
	signal parallel_adder_subtractorenavcc_output_wire                 : std_logic;                     -- Parallel_Adder_SubtractorenaVCC:output -> Parallel_Adder_Subtractor:ena
	signal delay_output_wire                                           : std_logic_vector(13 downto 0); -- Delay:output -> [Delay1:input, Multiplier:dataa]
	signal delay1_output_wire                                          : std_logic_vector(13 downto 0); -- Delay1:output -> Parallel_Adder_Subtractor:data0
	signal tsamp_output_wire                                           : std_logic_vector(13 downto 0); -- Tsamp:output -> Delay:input
	signal parallel_adder_subtractor_result_wire                       : std_logic_vector(14 downto 0); -- Parallel_Adder_Subtractor:result -> bus_14bits:input
	signal bus_14bits_output_wire                                      : std_logic_vector(13 downto 0); -- bus_14bits:output -> [Output_DAC0_0:input, Tsamp:input]
	signal cosw0_avec_facteur_de_multiplication_point_fixe_output_wire : std_logic_vector(18 downto 0); -- cosW0_avec_facteur_de_multiplication_point_fixe:output -> Multiplier:datab
	signal multiplier_result_wire                                      : std_logic_vector(32 downto 0); -- Multiplier:result -> division_facteur_de_multiplication_point_fixe:input
	signal division_facteur_de_multiplication_point_fixe_output_wire   : std_logic_vector(13 downto 0); -- division_facteur_de_multiplication_point_fixe:output -> Parallel_Adder_Subtractor:data1
	signal modulateur_bit_a_transmettre_0_output_wire                  : std_logic;                     -- modulateur_bit_a_transmettre_0:output -> [Delay1:sclr, Delay:sclr, Output_test_0:input]
	signal clock_125mhz_0_clock_output_reset                           : std_logic;                     -- Clock_125MHz_0:aclr_out -> [Delay1:aclr, Delay:aclr, Multiplier:aclr, Parallel_Adder_Subtractor:aclr]
	signal clock_125mhz_0_clock_output_clk                             : std_logic;                     -- Clock_125MHz_0:clock_out -> [Delay1:clock, Delay:clock, Multiplier:clock, Parallel_Adder_Subtractor:clock]

begin

	clock_50mhz_0 : component alt_dspbuilder_clock_GNF343OQUJ
		port map (
			clock_out => open,        -- clock_output.clk
			aclr_out  => open,        --             .reset
			clock     => Clock_50MHz, --        clock.clk
			aclr_n    => aclr         --             .reset_n
		);

	clock_125mhz_0 : component alt_dspbuilder_clock_GNF343OQUJ
		port map (
			clock_out => clock_125mhz_0_clock_output_clk,   -- clock_output.clk
			aclr_out  => clock_125mhz_0_clock_output_reset, --             .reset
			clock     => Clock_125MHz,                      --        clock.clk
			aclr_n    => aclr_125                           --             .reset_n
		);

	clock_2mhz_0 : component alt_dspbuilder_clock_GNF343OQUJ
		port map (
			clock_out => open,       -- clock_output.clk
			aclr_out  => open,       --             .reset
			clock     => Clock_2MHz, --        clock.clk
			aclr_n    => aclr_2      --             .reset_n
		);

	clock_62p5mhz_0 : component alt_dspbuilder_clock_GNF343OQUJ
		port map (
			clock_out => open,          -- clock_output.clk
			aclr_out  => open,          --             .reset
			clock     => Clock_62p5MHz, --        clock.clk
			aclr_n    => aclr_62p5      --             .reset_n
		);

	modulateur_bitclock_i_0 : component alt_dspbuilder_port_GN37ALZBS4
		port map (
			input  => modulateur_bitclock_i, --  input.wire
			output => open                   -- output.wire
		);

	output_test_0 : component alt_dspbuilder_port_GN37ALZBS4
		port map (
			input  => modulateur_bit_a_transmettre_0_output_wire, --  input.wire
			output => Output_test                                 -- output.wire
		);

	modulateur_bitclock_q_0 : component alt_dspbuilder_port_GN37ALZBS4
		port map (
			input  => modulateur_bitclock_q, --  input.wire
			output => open                   -- output.wire
		);

	tsamp : component alt_dspbuilder_bypass_GNGEVLMN77
		generic map (
			HDLTYPE => "STD_LOGIC_VECTOR",
			width   => 14
		)
		port map (
			input  => bus_14bits_output_wire, --  input.wire
			output => tsamp_output_wire       -- output.wire
		);

	delay : component alt_dspbuilder_delay_GN6TGYZDFK
		generic map (
			ClockPhase => "1",
			delay      => 1,
			use_init   => 1,
			BitPattern => "11111101101010",
			width      => 14
		)
		port map (
			input  => tsamp_output_wire,                          --      input.wire
			clock  => clock_125mhz_0_clock_output_clk,            -- clock_aclr.clk
			aclr   => clock_125mhz_0_clock_output_reset,          --           .reset
			output => delay_output_wire,                          --     output.wire
			sclr   => modulateur_bit_a_transmettre_0_output_wire, --       sclr.wire
			ena    => delayenavcc_output_wire                     --        ena.wire
		);

	delayenavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => delayenavcc_output_wire  -- output.wire
		);

	cosw0_avec_facteur_de_multiplication_point_fixe : component alt_dspbuilder_constant_GNR47HMCFS
		generic map (
			HDLTYPE    => "STD_LOGIC_VECTOR",
			BitPattern => "0011110011000001111",
			width      => 19
		)
		port map (
			output => cosw0_avec_facteur_de_multiplication_point_fixe_output_wire  -- output.wire
		);

	multiplier : component alt_dspbuilder_multiplier_GNVM2FSDDK
		generic map (
			DEDICATED_MULTIPLIER_CIRCUITRY => "YES",
			Signed                         => 1,
			OutputMsb                      => 32,
			aWidth                         => 14,
			bWidth                         => 19,
			OutputLsb                      => 0,
			pipeline                       => 0
		)
		port map (
			clock     => clock_125mhz_0_clock_output_clk,                             -- clock_aclr.clk
			aclr      => clock_125mhz_0_clock_output_reset,                           --           .reset
			dataa     => delay_output_wire,                                           --      dataa.wire
			datab     => cosw0_avec_facteur_de_multiplication_point_fixe_output_wire, --      datab.wire
			result    => multiplier_result_wire,                                      --     result.wire
			user_aclr => multiplieruser_aclrgnd_output_wire,                          --  user_aclr.wire
			ena       => multiplierenavcc_output_wire                                 --        ena.wire
		);

	multiplieruser_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => multiplieruser_aclrgnd_output_wire  -- output.wire
		);

	multiplierenavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => multiplierenavcc_output_wire  -- output.wire
		);

	modulateur_bit_a_transmettre_0 : component alt_dspbuilder_port_GN37ALZBS4
		port map (
			input  => modulateur_bit_a_transmettre,               --  input.wire
			output => modulateur_bit_a_transmettre_0_output_wire  -- output.wire
		);

	bus_14bits : component alt_dspbuilder_cast_GN6KYL5EP5
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => parallel_adder_subtractor_result_wire, --  input.wire
			output => bus_14bits_output_wire                 -- output.wire
		);

	modulateur_enable_0 : component alt_dspbuilder_port_GN37ALZBS4
		port map (
			input  => modulateur_enable, --  input.wire
			output => open               -- output.wire
		);

	delay1 : component alt_dspbuilder_delay_GNQOGXYDHZ
		generic map (
			ClockPhase => "1",
			delay      => 1,
			use_init   => 1,
			BitPattern => "11111011010100",
			width      => 14
		)
		port map (
			input  => delay_output_wire,                          --      input.wire
			clock  => clock_125mhz_0_clock_output_clk,            -- clock_aclr.clk
			aclr   => clock_125mhz_0_clock_output_reset,          --           .reset
			output => delay1_output_wire,                         --     output.wire
			sclr   => modulateur_bit_a_transmettre_0_output_wire, --       sclr.wire
			ena    => delay1enavcc_output_wire                    --        ena.wire
		);

	delay1enavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => delay1enavcc_output_wire  -- output.wire
		);

	output_dac0_0 : component alt_dspbuilder_port_GNBOOX3JQY
		port map (
			input  => bus_14bits_output_wire, --  input.wire
			output => Output_DAC0             -- output.wire
		);

	parallel_adder_subtractor : component alt_dspbuilder_parallel_adder_GNGXGUGRPY
		generic map (
			direction     => "-+",
			dataWidth     => 14,
			MaskValue     => "1",
			number_inputs => 2,
			pipeline      => 0
		)
		port map (
			clock     => clock_125mhz_0_clock_output_clk,                           -- clock_aclr.clk
			aclr      => clock_125mhz_0_clock_output_reset,                         --           .reset
			result    => parallel_adder_subtractor_result_wire,                     --     result.wire
			user_aclr => parallel_adder_subtractoruser_aclrgnd_output_wire,         --  user_aclr.wire
			ena       => parallel_adder_subtractorenavcc_output_wire,               --        ena.wire
			data0     => delay1_output_wire,                                        --      data0.wire
			data1     => division_facteur_de_multiplication_point_fixe_output_wire  --      data1.wire
		);

	parallel_adder_subtractoruser_aclrgnd : component alt_dspbuilder_gnd_GN
		port map (
			output => parallel_adder_subtractoruser_aclrgnd_output_wire  -- output.wire
		);

	parallel_adder_subtractorenavcc : component alt_dspbuilder_vcc_GN
		port map (
			output => parallel_adder_subtractorenavcc_output_wire  -- output.wire
		);

	division_facteur_de_multiplication_point_fixe : component alt_dspbuilder_cast_GNVFK2425V
		generic map (
			round    => 0,
			saturate => 0
		)
		port map (
			input  => multiplier_result_wire,                                    --  input.wire
			output => division_facteur_de_multiplication_point_fixe_output_wire  -- output.wire
		);

end architecture rtl; -- of Squelette_DSPBuilder_GN