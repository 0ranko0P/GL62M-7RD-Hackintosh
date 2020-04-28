Kexts list
======

* [`AppleALC`][alc_k]
* [`AtherosE2200Ethernet`][ethernet_k] 
* [`CPUFriend`][cpu_k]
* [`Lilu`][lilu_k]
* [`NoTouchID`][id_k]
* [`VirtualSMC`][smc_k] (Include sensor kexts)
* [`VoodooPS2Controller`][ps2_k]
* [`WhateverGreen`][green_k]

## Function keys
To use function keys on MSI keyboard the file at ``VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Keyboard/Contents/Info.plist`` need to be replaced by this [Info.plist][key_map].

More Custom Keyboard Mapping see [Wiki][ps2_wiki].

[alc_k]: https://github.com/acidanthera/AppleALC/releases
[ethernet_k]: https://github.com/Mieze/AtherosE2200Ethernet/releases
[cpu_k]: https://github.com/acidanthera/CPUFriend/releases
[lilu_k]: https://github.com/acidanthera/Lilu/releases
[key_map]: https://github.com/0ranko0P/GL62M-7RD-Hackintosh/blob/Catalina/kexts/Info.plist
[id_k]: https://github.com/al3xtjames/NoTouchID/releases
[smc_k]: https://github.com/acidanthera/VirtualSMC/releases
[ps2_k]: https://bitbucket.org/RehabMan/os-x-voodoo-ps2-controller/downloads/
[ps2_wiki]: https://github.com/RehabMan/OS-X-Voodoo-PS2-Controller/wiki/How-to-Use-Custom-Keyboard-Mapping
[green_k]: https://github.com/acidanthera/WhateverGreen/releases
