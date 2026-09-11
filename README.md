# 🖥️ NEON DESKTOP INSTALLER
### *by [neonheart711](https://github.com/neonheart711)*

> **Debian Proot + XFCE4 Desktop on Termux — Clean, Transparent, One-Command Setup**

---

## ⚡ Quick Install

Run this single command in Termux:

```bash
pkg update -y && pkg install wget -y && wget -O debian_install.sh [https://raw.githubusercontent.com/neonheart711/Termux-Desktops-Installer/main/debian_install.sh](https://raw.githubusercontent.com/neonheart711/Termux-Desktops-Installer/main/debian_install.sh) && chmod +x debian_install.sh && bash debian_install.sh
```

---

## ✨ Features

- **100% Real-Time Output:** No hidden downloads, suppressed errors, or truncated outputs (`tail` and `-q` flags removed).
- **Step-by-Step Indicators:** Visual progress counters `[X/7]` for every core dependency.
- **Non-Interactive Debian Build:** Runs without stopping or hanging on keyboard layout and timezone (`tzdata`) configuration prompts.
- **PulseAudio & Termux:X11 Ready:** Configured to direct audio through localhost and video via native `X11` server displays.
- **Smart Distro Detection:** Detects existing Debian rootfs installations to avoid redownloading unless required.

---

## 📋 What It Does

| Step | Action | Description |
|:---:|:---|:---|
| 🔧 | **Termux Environment** | Creates `~/.hushlogin` and initialises Android storage permissions. |
| 📦 | **Core Repos & Utilities** | Installs `x11-repo`, `tur-repo`, `termux-x11-nightly`, `pulseaudio`, `proot-distro`, `wget`, and `git`. |
| 🐧 | **Debian Rootfs** | Deploys an official Debian environment inside Termux via `proot-distro`. |
| 🖥️ | **XFCE4 Desktop** | Configures `nano`, `sudo`, `xfce4`, `xfce4-terminal`, and `dbus-x11` non-interactively inside Debian. |
| 🚀 | **Global Launcher Setup** | Creates an executable launch script at `$PREFIX/bin/debian`. |

---

## 🚀 Usage

1. Open the **Termux:X11** app on your Android device and keep it running in the background.
2. Return to **Termux** and execute:
 
```bash
debian
```
### for access debian terminal 
```bash
debian --cli
```

The script will launch PulseAudio, activate Termux:X11, and boot directly into the XFCE4 desktop.

---

## 📱 Requirements

- **Termux:** Latest build from [F-Droid](https://f-droid.org/en/packages/com.termux/) or GitHub Releases *(Do NOT use the Google Play Store build)*.
- **Termux:X11:** Companion APK installed.
- **Storage:** Minimum **3.5 GB – 4 GB** of free internal storage.
- **Android Version:** Android 7.0 (Nougat) or higher.
- **Internet:** Stable internet connection for downloading rootfs archives and packages.

---

## 🗂️ Installed Files

```
$PREFIX/bin/debian          ← Executable desktop launcher
~/.hushlogin                ← Silences default Termux MOTD on startup
```

---

## 🛠️ Troubleshooting

**Storage permission denied?**
Run manual storage setup:
```bash
termux-setup-storage
```

**Need a fresh installation?**
Wipe the existing Debian rootfs and rerun the installer:
```bash
proot-distro remove debian
bash debian_install.sh
```

**Black screen in Termux:X11?**
1. Force stop both **Termux** and **Termux:X11** from Android Settings.
2. Open **Termux:X11** first and leave it on screen.
3. Switch back to **Termux**, run `debian`, and immediately view **Termux:X11**.

---

## 📜 License

This project is licensed under the **Apache License 2.0**.

```
Copyright 2025 neonheart711

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

See the full [LICENSE](./LICENSE) file for details.

---

<div align="center">

Made with ❤️ by **neonheart711**  
[GitHub](https://github.com/neonheart711) • [Termux Desktops Installer](https://github.com/neonheart711/Termux-Desktops-Installer)

</div>

</div>
