p1=$1
p2=$2

ld -m elf_i386 -s -o $p1 $p2

echo "fim"
