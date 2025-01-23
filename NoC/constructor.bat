ECHO OFF
cls
echo "Montando o binario do bootloader"
nasm -f bin bootloader.asm -o bin/bootloader.bin
echo "Montando o Kernel"
nasm -f bin kernel.asm -o bin/kernel.bin
echo "Montando o Window"
nasm -f bin window.asm -o bin/window.bin
pause