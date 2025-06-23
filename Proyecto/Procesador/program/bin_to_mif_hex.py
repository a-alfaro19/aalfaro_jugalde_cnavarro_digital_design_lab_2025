#!/usr/bin/env python3

import sys

def bin_to_mif(input_file, output_file, width=32, depth=65536):
    with open(input_file, "rb") as f:
        binary = f.read()

    # Agrupar en palabras de 4 bytes (big endian)
    words = []
    for i in range(0, len(binary), 4):
        word = binary[i:i+4]
        if len(word) < 4:
            word = word.ljust(4, b'\x00')  # completar si faltan bytes
        value = int.from_bytes(word, byteorder='big')
        words.append(value)

    with open(output_file, "w") as f:
        f.write(f"WIDTH={width};\n")
        f.write(f"DEPTH={depth};\n\n")
        f.write("ADDRESS_RADIX=UNS;\n")
        f.write("DATA_RADIX=HEX;\n\n")
        f.write("CONTENT BEGIN\n")
        for i, word in enumerate(words):
            f.write(f"    {i:<6} : {word:08X};\n")
        if len(words) < depth:
            f.write(f"    [{len(words)}..{depth - 1}] : 00000000;\n")
        f.write("END;\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python3 bin_to_mif_hex.py entrada.bin salida.mif")
    else:
        bin_to_mif(sys.argv[1], sys.argv[2])
