# Variables
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
ASFLAGS = -mcpu=arm7tdmi -mthumb-interwork
LDFLAGS = -T link.ld

SRC = pong_game.s
OBJ = pong_game.o
BIN = pong_game.bin
MIF = pong_game.mif

all: $(MIF)

# Ensamblar .s a .o
$(OBJ): $(SRC)
	$(AS) $(ASFLAGS) -o $@ $<

# Linkear .o a binario plano
$(BIN): $(OBJ)
	$(LD) $(LDFLAGS) -o pong_game.elf $<
	$(OBJCOPY) -O binary pong_game.elf $@

# Convertir .bin a .mif
$(MIF): $(BIN)
	python3 bin_to_mif.py $< $@

clean:
	rm -f $(OBJ) pong_game.elf $(BIN) $(MIF)


