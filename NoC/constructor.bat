ECHO OFF
cls
echo "Montando o binario do bootloader"
nasm -f bin bootloader.asm -o bootloader.bin
echo "Montando o Kernel"
nasm -f bin kernel.asm -o kernel.bin
pause