//
// SSDT-SMBUS.dsl
//
// Adding SMBUS device
//
// Fork from: RehabMan:
// https://raw.githubusercontent.com/RehabMan/OS-X-Clover-Laptop-Config/master/hotpatch/SSDT-SMBUS.dsl
// commit 75a574b66585339f720edca2710a1267908ba489
//
// Licensed under GNU General Public License v2.0
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/License.md

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "_SMBUS", 0)
{
#endif
    Device(_SB.PCI0.SBUS.BUS0)
    {
        Name(_CID, "smbus")
        Name(_ADR, Zero)
        Device(DVL0)
        {
            Name(_ADR, 0x57)
            Name(_CID, "diagsvault")
            Method(_DSM, 4)
            {
                If (!Arg2) { Return (Buffer() { 0x03 } ) }
                Return (Package() { "address", 0x57 })
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF