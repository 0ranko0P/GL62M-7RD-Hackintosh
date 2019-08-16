//
// SSDT-DDGPU.dsl
//
// Disabling GTX1050 for MSI GL62M 7RD
// _ON & _Off method were found in SSDT-8-OptTabl.aml without EC code
//
// Fork from RehabMan: https://raw.githubusercontent.com/RehabMan/OS-X-Clover-Laptop-Config/master/hotpatch/SSDT-DDGPU.dsl
// commit 75a574b66585339f720edca2710a1267908ba489
//
// Note: https://www.tonymacx86.com/threads/guide-disabling-discrete-graphics-in-dual-gpu-laptops.163772/
//
// Licensed under GNU General Public License v2.0
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/License.md

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "_DDGPU", 0)
{
#endif

    External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
    // External(_SB.PCI0.PEGP.DGFX._OFF, MethodObj)

    Device(RMD1)
    {
        Name(_HID, "RMD10000")
        Method(_INI)
        {
            // disable discrete graphics (Nvidia/Radeon) if it is present
             If (CondRefOf(\_SB.PCI0.PEG0.PEGP._OFF)) { \_SB.PCI0.PEG0.PEGP._OFF() }
            // If (CondRefOf(\_SB.PCI0.PEGP.DGFX._OFF)) { \_SB.PCI0.PEGP.DGFX._OFF() }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF