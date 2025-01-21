ECHO OFF
cls
echo "Montando o binario do bootloader"
nasm -f bin bootloader.asm -o bootloader.bin
echo "Montando o Kernel"
nasm -f bin kernel.asm -o kernel.bin
echo "Montando o Window"
nasm -f bin window.asm -o window.bin
pause