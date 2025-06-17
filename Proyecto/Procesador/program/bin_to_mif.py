import sys

def bin_to_mif(bin_file, mif_file, width=8, depth=None):
    with open(bin_file, "rb") as f:
        data = f.read()

    if depth is None:
        depth = len(data)

    with open(mif_file, "w") as f:
        f.write(f"WIDTH={width};\n")
        f.write(f"DEPTH={depth};\n\n")
        f.write("ADDRESS_RADIX=HEX;\n")
        f.write("DATA_RADIX=HEX;\n\n")
        f.write("CONTENT BEGIN\n")

        for i, byte in enumerate(data):
            f.write(f"\t{i:X} : {byte:02X};\n")

        f.write("END;\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: bin_to_mif.py archivo.bin archivo.mif")
        sys.exit(1)

    bin_to_mif(sys.argv[1], sys.argv[2])
