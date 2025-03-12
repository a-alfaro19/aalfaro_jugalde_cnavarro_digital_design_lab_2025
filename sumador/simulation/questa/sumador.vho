-- Copyright (C) 2022  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 22.1std.0 Build 915 10/25/2022 SC Lite Edition"

-- DATE "03/11/2025 16:34:48"

-- 
-- Device: Altera 5CSXFC6D6F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	sumador_top IS
    PORT (
	SW : IN std_logic_vector(8 DOWNTO 0);
	SEG : OUT std_logic_vector(6 DOWNTO 0);
	SEG_COUT : OUT std_logic_vector(6 DOWNTO 0)
	);
END sumador_top;

-- Design Ports Information
-- SW[8]	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG[0]	=>  Location: PIN_AH18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG[1]	=>  Location: PIN_AG18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG[2]	=>  Location: PIN_AH17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG[3]	=>  Location: PIN_AG16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG[4]	=>  Location: PIN_AG17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG[5]	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG[6]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG_COUT[0]	=>  Location: PIN_V17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG_COUT[1]	=>  Location: PIN_AE17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG_COUT[2]	=>  Location: PIN_AE18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG_COUT[3]	=>  Location: PIN_AD17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG_COUT[4]	=>  Location: PIN_AE16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG_COUT[5]	=>  Location: PIN_V16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEG_COUT[6]	=>  Location: PIN_AF16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[0]	=>  Location: PIN_AB30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[4]	=>  Location: PIN_W25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[1]	=>  Location: PIN_Y27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[5]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[2]	=>  Location: PIN_AB28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[6]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[3]	=>  Location: PIN_AC30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SW[7]	=>  Location: PIN_AD30,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF sumador_top IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_SW : std_logic_vector(8 DOWNTO 0);
SIGNAL ww_SEG : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_SEG_COUT : std_logic_vector(6 DOWNTO 0);
SIGNAL \SW[8]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \SW[0]~input_o\ : std_logic;
SIGNAL \SW[4]~input_o\ : std_logic;
SIGNAL \SUMA|U0|p~combout\ : std_logic;
SIGNAL \SW[5]~input_o\ : std_logic;
SIGNAL \SW[1]~input_o\ : std_logic;
SIGNAL \SUMA|U1|s~combout\ : std_logic;
SIGNAL \SW[7]~input_o\ : std_logic;
SIGNAL \SW[2]~input_o\ : std_logic;
SIGNAL \SW[6]~input_o\ : std_logic;
SIGNAL \SUMA|U1|cout~combout\ : std_logic;
SIGNAL \SW[3]~input_o\ : std_logic;
SIGNAL \SUMA|U3|s~combout\ : std_logic;
SIGNAL \SUMA|U2|s~combout\ : std_logic;
SIGNAL \DIS0|Mux6~0_combout\ : std_logic;
SIGNAL \DIS0|Mux5~0_combout\ : std_logic;
SIGNAL \DIS0|Mux4~0_combout\ : std_logic;
SIGNAL \DIS0|Mux3~0_combout\ : std_logic;
SIGNAL \DIS0|Mux2~0_combout\ : std_logic;
SIGNAL \DIS0|Mux1~0_combout\ : std_logic;
SIGNAL \DIS0|Mux0~0_combout\ : std_logic;
SIGNAL \SUMA|U3|cout~combout\ : std_logic;
SIGNAL \SUMA|U2|ALT_INV_s~combout\ : std_logic;
SIGNAL \SUMA|U3|ALT_INV_s~combout\ : std_logic;
SIGNAL \ALT_INV_SW[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[4]~input_o\ : std_logic;
SIGNAL \DIS0|ALT_INV_Mux6~0_combout\ : std_logic;
SIGNAL \ALT_INV_SW[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[0]~input_o\ : std_logic;
SIGNAL \SUMA|U0|ALT_INV_p~combout\ : std_logic;
SIGNAL \ALT_INV_SW[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[1]~input_o\ : std_logic;
SIGNAL \SUMA|U1|ALT_INV_cout~combout\ : std_logic;
SIGNAL \ALT_INV_SW[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_SW[3]~input_o\ : std_logic;
SIGNAL \SUMA|U1|ALT_INV_s~combout\ : std_logic;

BEGIN

ww_SW <= SW;
SEG <= ww_SEG;
SEG_COUT <= ww_SEG_COUT;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\SUMA|U2|ALT_INV_s~combout\ <= NOT \SUMA|U2|s~combout\;
\SUMA|U3|ALT_INV_s~combout\ <= NOT \SUMA|U3|s~combout\;
\ALT_INV_SW[5]~input_o\ <= NOT \SW[5]~input_o\;
\ALT_INV_SW[4]~input_o\ <= NOT \SW[4]~input_o\;
\DIS0|ALT_INV_Mux6~0_combout\ <= NOT \DIS0|Mux6~0_combout\;
\ALT_INV_SW[6]~input_o\ <= NOT \SW[6]~input_o\;
\ALT_INV_SW[0]~input_o\ <= NOT \SW[0]~input_o\;
\SUMA|U0|ALT_INV_p~combout\ <= NOT \SUMA|U0|p~combout\;
\ALT_INV_SW[7]~input_o\ <= NOT \SW[7]~input_o\;
\ALT_INV_SW[1]~input_o\ <= NOT \SW[1]~input_o\;
\SUMA|U1|ALT_INV_cout~combout\ <= NOT \SUMA|U1|cout~combout\;
\ALT_INV_SW[2]~input_o\ <= NOT \SW[2]~input_o\;
\ALT_INV_SW[3]~input_o\ <= NOT \SW[3]~input_o\;
\SUMA|U1|ALT_INV_s~combout\ <= NOT \SUMA|U1|s~combout\;

-- Location: IOOBUF_X56_Y0_N53
\SEG[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DIS0|ALT_INV_Mux6~0_combout\,
	devoe => ww_devoe,
	o => ww_SEG(0));

-- Location: IOOBUF_X58_Y0_N76
\SEG[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DIS0|Mux5~0_combout\,
	devoe => ww_devoe,
	o => ww_SEG(1));

-- Location: IOOBUF_X56_Y0_N36
\SEG[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DIS0|Mux4~0_combout\,
	devoe => ww_devoe,
	o => ww_SEG(2));

-- Location: IOOBUF_X50_Y0_N76
\SEG[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DIS0|Mux3~0_combout\,
	devoe => ww_devoe,
	o => ww_SEG(3));

-- Location: IOOBUF_X50_Y0_N93
\SEG[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DIS0|Mux2~0_combout\,
	devoe => ww_devoe,
	o => ww_SEG(4));

-- Location: IOOBUF_X80_Y0_N2
\SEG[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DIS0|Mux1~0_combout\,
	devoe => ww_devoe,
	o => ww_SEG(5));

-- Location: IOOBUF_X60_Y0_N19
\SEG[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \DIS0|Mux0~0_combout\,
	devoe => ww_devoe,
	o => ww_SEG(6));

-- Location: IOOBUF_X60_Y0_N2
\SEG_COUT[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_SEG_COUT(0));

-- Location: IOOBUF_X50_Y0_N42
\SEG_COUT[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SUMA|U3|cout~combout\,
	devoe => ww_devoe,
	o => ww_SEG_COUT(1));

-- Location: IOOBUF_X66_Y0_N42
\SEG_COUT[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SUMA|U3|cout~combout\,
	devoe => ww_devoe,
	o => ww_SEG_COUT(2));

-- Location: IOOBUF_X64_Y0_N19
\SEG_COUT[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SUMA|U3|cout~combout\,
	devoe => ww_devoe,
	o => ww_SEG_COUT(3));

-- Location: IOOBUF_X52_Y0_N36
\SEG_COUT[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_SEG_COUT(4));

-- Location: IOOBUF_X52_Y0_N2
\SEG_COUT[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_SEG_COUT(5));

-- Location: IOOBUF_X52_Y0_N53
\SEG_COUT[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SUMA|U3|cout~combout\,
	devoe => ww_devoe,
	o => ww_SEG_COUT(6));

-- Location: IOIBUF_X89_Y21_N4
\SW[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(0),
	o => \SW[0]~input_o\);

-- Location: IOIBUF_X89_Y20_N44
\SW[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(4),
	o => \SW[4]~input_o\);

-- Location: LABCELL_X88_Y12_N30
\SUMA|U0|p\ : cyclonev_lcell_comb
-- Equation(s):
-- \SUMA|U0|p~combout\ = ( \SW[4]~input_o\ & ( !\SW[0]~input_o\ ) ) # ( !\SW[4]~input_o\ & ( \SW[0]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111111110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_SW[0]~input_o\,
	dataf => \ALT_INV_SW[4]~input_o\,
	combout => \SUMA|U0|p~combout\);

-- Location: IOIBUF_X89_Y20_N61
\SW[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(5),
	o => \SW[5]~input_o\);

-- Location: IOIBUF_X89_Y25_N21
\SW[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(1),
	o => \SW[1]~input_o\);

-- Location: LABCELL_X88_Y12_N39
\SUMA|U1|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \SUMA|U1|s~combout\ = ( \SW[1]~input_o\ & ( \SW[0]~input_o\ & ( !\SW[4]~input_o\ $ (\SW[5]~input_o\) ) ) ) # ( !\SW[1]~input_o\ & ( \SW[0]~input_o\ & ( !\SW[4]~input_o\ $ (!\SW[5]~input_o\) ) ) ) # ( \SW[1]~input_o\ & ( !\SW[0]~input_o\ & ( 
-- !\SW[5]~input_o\ ) ) ) # ( !\SW[1]~input_o\ & ( !\SW[0]~input_o\ & ( \SW[5]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111111111110000000001010101101010101010101001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[4]~input_o\,
	datad => \ALT_INV_SW[5]~input_o\,
	datae => \ALT_INV_SW[1]~input_o\,
	dataf => \ALT_INV_SW[0]~input_o\,
	combout => \SUMA|U1|s~combout\);

-- Location: IOIBUF_X89_Y25_N38
\SW[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(7),
	o => \SW[7]~input_o\);

-- Location: IOIBUF_X89_Y21_N38
\SW[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(2),
	o => \SW[2]~input_o\);

-- Location: IOIBUF_X89_Y20_N78
\SW[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(6),
	o => \SW[6]~input_o\);

-- Location: LABCELL_X88_Y12_N48
\SUMA|U1|cout\ : cyclonev_lcell_comb
-- Equation(s):
-- \SUMA|U1|cout~combout\ = ( \SW[1]~input_o\ & ( \SW[0]~input_o\ & ( (\SW[4]~input_o\) # (\SW[5]~input_o\) ) ) ) # ( !\SW[1]~input_o\ & ( \SW[0]~input_o\ & ( (\SW[5]~input_o\ & \SW[4]~input_o\) ) ) ) # ( \SW[1]~input_o\ & ( !\SW[0]~input_o\ & ( 
-- \SW[5]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000010101010101010100000101000001010101111101011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[5]~input_o\,
	datac => \ALT_INV_SW[4]~input_o\,
	datae => \ALT_INV_SW[1]~input_o\,
	dataf => \ALT_INV_SW[0]~input_o\,
	combout => \SUMA|U1|cout~combout\);

-- Location: IOIBUF_X89_Y25_N55
\SW[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(3),
	o => \SW[3]~input_o\);

-- Location: LABCELL_X88_Y12_N54
\SUMA|U3|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \SUMA|U3|s~combout\ = ( \SW[3]~input_o\ & ( !\SW[7]~input_o\ $ (((!\SW[2]~input_o\ & (\SW[6]~input_o\ & \SUMA|U1|cout~combout\)) # (\SW[2]~input_o\ & ((\SUMA|U1|cout~combout\) # (\SW[6]~input_o\))))) ) ) # ( !\SW[3]~input_o\ & ( !\SW[7]~input_o\ $ 
-- (((!\SW[2]~input_o\ & ((!\SW[6]~input_o\) # (!\SUMA|U1|cout~combout\))) # (\SW[2]~input_o\ & (!\SW[6]~input_o\ & !\SUMA|U1|cout~combout\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101011001101010010101100110101010101001100101011010100110010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[7]~input_o\,
	datab => \ALT_INV_SW[2]~input_o\,
	datac => \ALT_INV_SW[6]~input_o\,
	datad => \SUMA|U1|ALT_INV_cout~combout\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \SUMA|U3|s~combout\);

-- Location: LABCELL_X88_Y12_N42
\SUMA|U2|s\ : cyclonev_lcell_comb
-- Equation(s):
-- \SUMA|U2|s~combout\ = ( \SW[1]~input_o\ & ( \SW[4]~input_o\ & ( !\SW[6]~input_o\ $ (!\SW[2]~input_o\ $ (((\SW[0]~input_o\) # (\SW[5]~input_o\)))) ) ) ) # ( !\SW[1]~input_o\ & ( \SW[4]~input_o\ & ( !\SW[6]~input_o\ $ (!\SW[2]~input_o\ $ (((\SW[5]~input_o\ 
-- & \SW[0]~input_o\)))) ) ) ) # ( \SW[1]~input_o\ & ( !\SW[4]~input_o\ & ( !\SW[5]~input_o\ $ (!\SW[6]~input_o\ $ (\SW[2]~input_o\)) ) ) ) # ( !\SW[1]~input_o\ & ( !\SW[4]~input_o\ & ( !\SW[6]~input_o\ $ (!\SW[2]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001111001100011001101001100100110110110010010110110010010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[5]~input_o\,
	datab => \ALT_INV_SW[6]~input_o\,
	datac => \ALT_INV_SW[0]~input_o\,
	datad => \ALT_INV_SW[2]~input_o\,
	datae => \ALT_INV_SW[1]~input_o\,
	dataf => \ALT_INV_SW[4]~input_o\,
	combout => \SUMA|U2|s~combout\);

-- Location: LABCELL_X88_Y12_N3
\DIS0|Mux6~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DIS0|Mux6~0_combout\ = ( \SUMA|U3|s~combout\ & ( \SUMA|U2|s~combout\ & ( (\SUMA|U1|s~combout\) # (\SUMA|U0|p~combout\) ) ) ) # ( !\SUMA|U3|s~combout\ & ( \SUMA|U2|s~combout\ & ( (!\SUMA|U0|p~combout\) # (!\SUMA|U1|s~combout\) ) ) ) # ( 
-- \SUMA|U3|s~combout\ & ( !\SUMA|U2|s~combout\ ) ) # ( !\SUMA|U3|s~combout\ & ( !\SUMA|U2|s~combout\ & ( \SUMA|U1|s~combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111111111111111111111111100111111000011111100111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \SUMA|U0|ALT_INV_p~combout\,
	datac => \SUMA|U1|ALT_INV_s~combout\,
	datae => \SUMA|U3|ALT_INV_s~combout\,
	dataf => \SUMA|U2|ALT_INV_s~combout\,
	combout => \DIS0|Mux6~0_combout\);

-- Location: LABCELL_X88_Y12_N6
\DIS0|Mux5~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DIS0|Mux5~0_combout\ = ( \SUMA|U3|s~combout\ & ( \SUMA|U2|s~combout\ & ( (!\SUMA|U1|s~combout\ & \SUMA|U0|p~combout\) ) ) ) # ( !\SUMA|U3|s~combout\ & ( \SUMA|U2|s~combout\ & ( (\SUMA|U1|s~combout\ & \SUMA|U0|p~combout\) ) ) ) # ( !\SUMA|U3|s~combout\ & 
-- ( !\SUMA|U2|s~combout\ & ( (\SUMA|U0|p~combout\) # (\SUMA|U1|s~combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001111111111000000000000000000000000001100110000000011001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \SUMA|U1|ALT_INV_s~combout\,
	datad => \SUMA|U0|ALT_INV_p~combout\,
	datae => \SUMA|U3|ALT_INV_s~combout\,
	dataf => \SUMA|U2|ALT_INV_s~combout\,
	combout => \DIS0|Mux5~0_combout\);

-- Location: LABCELL_X88_Y12_N15
\DIS0|Mux4~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DIS0|Mux4~0_combout\ = ( !\SUMA|U3|s~combout\ & ( \SUMA|U2|s~combout\ & ( (!\SUMA|U1|s~combout\) # (\SUMA|U0|p~combout\) ) ) ) # ( \SUMA|U3|s~combout\ & ( !\SUMA|U2|s~combout\ & ( (\SUMA|U0|p~combout\ & !\SUMA|U1|s~combout\) ) ) ) # ( 
-- !\SUMA|U3|s~combout\ & ( !\SUMA|U2|s~combout\ & ( \SUMA|U0|p~combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100000011000011110011111100110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \SUMA|U0|ALT_INV_p~combout\,
	datac => \SUMA|U1|ALT_INV_s~combout\,
	datae => \SUMA|U3|ALT_INV_s~combout\,
	dataf => \SUMA|U2|ALT_INV_s~combout\,
	combout => \DIS0|Mux4~0_combout\);

-- Location: LABCELL_X88_Y12_N18
\DIS0|Mux3~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DIS0|Mux3~0_combout\ = ( \SUMA|U2|s~combout\ & ( (!\SUMA|U1|s~combout\ & (!\SUMA|U3|s~combout\ & !\SUMA|U0|p~combout\)) # (\SUMA|U1|s~combout\ & ((\SUMA|U0|p~combout\))) ) ) # ( !\SUMA|U2|s~combout\ & ( (!\SUMA|U3|s~combout\ & (!\SUMA|U1|s~combout\ & 
-- \SUMA|U0|p~combout\)) # (\SUMA|U3|s~combout\ & (\SUMA|U1|s~combout\ & !\SUMA|U0|p~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001100000011000000110000001100010000011100000111000001110000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \SUMA|U3|ALT_INV_s~combout\,
	datab => \SUMA|U1|ALT_INV_s~combout\,
	datac => \SUMA|U0|ALT_INV_p~combout\,
	dataf => \SUMA|U2|ALT_INV_s~combout\,
	combout => \DIS0|Mux3~0_combout\);

-- Location: LABCELL_X88_Y12_N21
\DIS0|Mux2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DIS0|Mux2~0_combout\ = ( \SUMA|U2|s~combout\ & ( (\SUMA|U3|s~combout\ & ((!\SUMA|U0|p~combout\) # (\SUMA|U1|s~combout\))) ) ) # ( !\SUMA|U2|s~combout\ & ( (!\SUMA|U3|s~combout\ & (\SUMA|U1|s~combout\ & !\SUMA|U0|p~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000000100000001000000010000001010001010100010101000101010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \SUMA|U3|ALT_INV_s~combout\,
	datab => \SUMA|U1|ALT_INV_s~combout\,
	datac => \SUMA|U0|ALT_INV_p~combout\,
	dataf => \SUMA|U2|ALT_INV_s~combout\,
	combout => \DIS0|Mux2~0_combout\);

-- Location: LABCELL_X88_Y12_N27
\DIS0|Mux1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DIS0|Mux1~0_combout\ = ( \SUMA|U2|s~combout\ & ( (!\SUMA|U0|p~combout\ & ((\SUMA|U3|s~combout\) # (\SUMA|U1|s~combout\))) # (\SUMA|U0|p~combout\ & (!\SUMA|U1|s~combout\ $ (\SUMA|U3|s~combout\))) ) ) # ( !\SUMA|U2|s~combout\ & ( (\SUMA|U0|p~combout\ & 
-- (\SUMA|U1|s~combout\ & \SUMA|U3|s~combout\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000101000000000000010101011010101011110101101010101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \SUMA|U0|ALT_INV_p~combout\,
	datac => \SUMA|U1|ALT_INV_s~combout\,
	datad => \SUMA|U3|ALT_INV_s~combout\,
	dataf => \SUMA|U2|ALT_INV_s~combout\,
	combout => \DIS0|Mux1~0_combout\);

-- Location: LABCELL_X88_Y12_N24
\DIS0|Mux0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \DIS0|Mux0~0_combout\ = ( \SUMA|U2|s~combout\ & ( (!\SUMA|U1|s~combout\ & (!\SUMA|U0|p~combout\ $ (\SUMA|U3|s~combout\))) ) ) # ( !\SUMA|U2|s~combout\ & ( (\SUMA|U0|p~combout\ & (!\SUMA|U1|s~combout\ $ (\SUMA|U3|s~combout\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000000011000011000000001111000000000011001100000000001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \SUMA|U1|ALT_INV_s~combout\,
	datac => \SUMA|U0|ALT_INV_p~combout\,
	datad => \SUMA|U3|ALT_INV_s~combout\,
	dataf => \SUMA|U2|ALT_INV_s~combout\,
	combout => \DIS0|Mux0~0_combout\);

-- Location: LABCELL_X88_Y12_N57
\SUMA|U3|cout\ : cyclonev_lcell_comb
-- Equation(s):
-- \SUMA|U3|cout~combout\ = ( \SW[3]~input_o\ & ( ((!\SW[2]~input_o\ & (\SUMA|U1|cout~combout\ & \SW[6]~input_o\)) # (\SW[2]~input_o\ & ((\SW[6]~input_o\) # (\SUMA|U1|cout~combout\)))) # (\SW[7]~input_o\) ) ) # ( !\SW[3]~input_o\ & ( (\SW[7]~input_o\ & 
-- ((!\SW[2]~input_o\ & (\SUMA|U1|cout~combout\ & \SW[6]~input_o\)) # (\SW[2]~input_o\ & ((\SW[6]~input_o\) # (\SUMA|U1|cout~combout\))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100010101000000010001010101010111011111110101011101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_SW[7]~input_o\,
	datab => \ALT_INV_SW[2]~input_o\,
	datac => \SUMA|U1|ALT_INV_cout~combout\,
	datad => \ALT_INV_SW[6]~input_o\,
	dataf => \ALT_INV_SW[3]~input_o\,
	combout => \SUMA|U3|cout~combout\);

-- Location: IOIBUF_X12_Y81_N52
\SW[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(8),
	o => \SW[8]~input_o\);

-- Location: MLABCELL_X52_Y16_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


