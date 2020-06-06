<img src="https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Logos/OpenCore_with_text_Small.png" width="200" height="48"/>

MSI-GL62M 7RD Hackintosh
======
[![works badge](https://cdn.jsdelivr.net/gh/nikku/works-on-my-machine@v0.2.0/badge.svg)][project_link]

Hackintosh clover configuration for [**MSI GL62M 7RD**][msi_overview].

With a few modifications, can work for all GL62M 7RD version *theoretically*.
Tested platform: `GL62M 7RD-223cn`.

Most of functions are working, include built-in camera, audio, Touchkpad, sleep and HDMI.

## Screenshots
![about][about_pic]

## Specifications
| Basic | Spec Sheet |
|--|--|
| CPU | Intel i7-7700HQ |
| GPU | HD630 (eDP) |
| Chipset | Intel HM175 |
| Audio | Realtek ALC898 |
| Ethernet | Atheros AR8175 |
| WiFi | Broadcom BCM94350ZAE/DW1820A (M.2 2230) |
| Touchkpad | Synaptics (PS2) | 
| USB controller | 100/C230 Series xHCI |

## BIOS Configuration
Make sure at least upgrade your [BIOS][msi_bios] to `E16J9IMS.324` and [Firmware][msi_firmware] up to `16J9EMS1.112`.

| Settings |  |
|--|--|
| `CFG Lock` | Disable |
| `CSM` | Disable |
| Fast Boot | Disable |
| `Intel Speed Shift`(aka. HWP) | Enable |
| Secure Boot | Disable |

**Some options only available in advanced mode:**\
In BIOS, holding **ALT + RIGHT-CTRL + SHIFT** together then press **F2**

<pre>
[Advanced] tab
├─ Power & Performance
│  └─ CPU-Power Management Control
│     ├─ <b>Intel(R) Speed Shift Technology</b>
│     └─ CPU Lock Configuration
│        └─ <b>CFG Lock</b>
└─ CSM Configuration
   └─ <b>CSM Support</b>
</pre>

## Known issues
* MiniDP
* SD card reader

## Getting Started
[OpenCore Laptop Guide][dortania_link].

## WiFi & Bluetooth
The DW1820A/BCM94350ZAE have different models:
![1820A versions][1820a_models]
It is best to have model CN-0VW3T3.
For more details refer [osxlatitude][wlan_ts_link].

Replace built-in Intel card to Broadcom BCM94350ZAE/DW1820A.

How to tear down: [Youtube][tear_down] (This video is for `7REX 1252`, but the procedure is very similar.).

```Always remove the power and battery first!!```

![tear down][tear_down_pic]

 [Kext][brcm] part for BrcmPatchRAM installation.
 [Bluetooth Troubleshooting][bt_ts_link]

## UEFI drivers
``` c++
AudioDxe
OpenCanopy
OpenRuntime
Ps2KeyboardDxe
// HFSPlus to boot installer
```

## Post Install
[Follow Dortania guide][dortania_link].
And skip these parts:
``` c++
Fixing Audio // fixed
Fixing CFG Lock // unlocked in BIOS
Fixing USB // fixed
Emulated NVRAM // natively supported in GL62M 
Fixing Power Management // fixed
Fixing Battery Status // fixed
```
* Hide Picker Screen
Misc -> Boot -> ShowPicker -> set to False

Holding Option or ESC key to show picker(like a real Mac)

* PlayChime
Download file from [OcBinaryData][oc_boot_wav], and place it under OC/Resources/Audio

UEFI -> Audio -> PlayChime -> set to True

## Note 
More USB ports info can be found at [SSDT-UIAC.dsl][usb_map]

[1820a_models]: https://raw.githubusercontent.com/0ranko0P/GL62M-7RD-Hackintosh/Catalina_DW1820A/screenshots/dw1820A.png
[about_pic]:https://raw.githubusercontent.com/0ranko0P/GL62M-7RD-Hackintosh/Catalina_DW1820A/screenshots/About.png
[brcm]: https://github.com/0ranko0P/GL62M-7RD-Hackintosh/tree/Catalina_DW1820A/kexts#wifiac--bt4le-dw1820a
[bt_ts_link]: https://osxlatitude.com/forums/topic/11540-dw1820a-the-general-troubleshooting-thread
[dortania_link]: https://dortania.github.io/oc-laptop-guide
[dortania_link_post]: https://dortania.github.io/vanilla-laptop-guide/post-install
[tear_down]: https://www.youtube.com/watch?v=-WHgFWf_66A
[tear_down_pic]: https://raw.githubusercontent.com/0ranko0P/GL62M-7RD-Hackintosh/Catalina_DW1820A/screenshots/Tear_down.png
[wifi_guide]: https://www.tonymacx86.com/threads/broadcom-wifi-bluetooth-guide.242423
[msi_overview]: https://www.msi.com/Laptop/support/GL62M-7RD
[msi_bios]: https://www.msi.com/Laptop/support/GL62M-7RD#down-bios
[msi_firmware]: https://www.msi.com/Laptop/support/GL62M-7RD#down-firmware
[oc_boot_wav]: https://github.com/acidanthera/OcBinaryData/blob/master/Resources/Audio/OCEFIAudio_VoiceOver_Boot.wav
[project_link]: https://github.com/0ranko0P/GL62M-7RD-Hackintosh
[usb_map]:  https://github.com/0ranko0P/GL62M-7RD-Hackintosh/blob/Catalina_DW1820A/hotpatchs/deprecated/SSDT-UIAC.dsl
[wlan_ts_link]: https://osxlatitude.com/forums/topic/11322-broadcom-bcm4350-cards-under-high-sierramojavecatalina
