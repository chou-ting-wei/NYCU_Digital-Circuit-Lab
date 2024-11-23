main:
	make clean
	iverilog -o sha256_sim sha256.v tb_sha256.v
	vvp sha256_sim

clean:
	rm -f sha256_sim