# SimpleOS

SimpleOS is a minimalist experimental operating system designed for learning and exploration. It is written in Assembly and C and can run in a virtual or physical environment.

## Features
- Custom bootloader.
- Basic kernel with essential functionalities.
- Minimalist window system.

---

## Prerequisites

Make sure you have the following programs installed on your machine:
- **VirtualBox** (6.1 or higher)
- **FergoRaw** (for creating disk images)
- **NASM Assembler** (2.15 or higher) and **GCC** or **LLVM Clang++**
- **Rufus** (4.5 or higher)

---

## Instructions

### 1. Assembling the code

Run the `Constructor.bat` file or the commands below manually:

#### Bootloader:
```bash
nasm -f bin bootloader.asm -o bootloader.bin
```

#### Kernel:
```bash
nasm -f bin kernel.asm -o kernel.bin
```

#### Window system:
```bash
nasm -f bin window.asm -o window.bin
```

---

### 2. Creating an image with FergoRaw

After generating the binary files, add them to **FergoRaw** in the correct size order:
- **Sector 1**: `bootloader.bin` (0–512 bytes)
- **Sector 2**: `kernel.bin` (0–512 bytes)
- **Sector 3**: `window.bin` (0–512 bytes)

If any file exceeds 512 bytes, adjust the sectors as indicated:

```plaintext
Sector 1: bootloader.bin
Sector 2: kernel.bin (first 512 bytes)
Sector 3: kernel.bin (remainder)
Sector 4: window.bin
```

---

### 3. Transferring to a USB with Rufus

1. Open **Rufus** and select the image file created in **FergoRaw**.
2. Configure the USB device and start transferring.

---

### 4. Configuring VirtualBox

#### Creating a VMDK file
With the USB connected, run the following commands in the terminal:

1. Navigate to the VirtualBox directory:
   ```bash
   cd %programfiles%\oracle\virtualbox
   ```

2. Create the VMDK file:
   ```bash
   VBoxManage internalcommands createrawvmdk -filename "%USERPROFILE%\.VirtualBox\usb.vmdk" -rawdisk \\.\PhysicalDrive[USB_disk_number]
   ```

#### Configuring the virtual machine
1. Create a new virtual machine in VirtualBox.
2. Assign the VMDK file to the storage drive.
3. Start the virtual machine to test SimpleOS.

---

## Contribution

Contributions are welcome! Follow these steps:
1. Fork the repository.
2. Create a branch for your changes.
3. Submit a Pull Request with a detailed description.

---

## Contact

If you have questions or encounter problems, please contact:
- **Email**: vinicius182102@gmail.com

---