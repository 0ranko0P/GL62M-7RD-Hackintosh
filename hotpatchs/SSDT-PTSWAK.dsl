//
// SSDT-PTSWAK.dsl
//
// Overriding _PTS and _WAK
// To solve GL72M's discrete GPU get powered on after the wake.
//
// Fork from RehabMan:
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/hotpatch/SSDT-PTSWAK.dsl
// commit 75a574b66585339f720edca2710a1267908ba489
//
// Licensed under GNU General Public License v2.0
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/License.md

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "_PTSWAK", 0)
{
#endif
    External(ZPTS, MethodObj)
    External(ZWAK, MethodObj)

    External(_SB.PCI0.PEG0.PEGP._ON, MethodObj)
    External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
    // External(_SB.PCI0.PEGP.DGFX._ON, MethodObj)
    // External(_SB.PCI0.PEGP.DGFX._OFF, MethodObj)

    External(RMCF.DPTS, IntObj) // 1

    // In DSDT, native _PTS and _WAK are renamed ZPTS/ZWAK
    // As a result, calls to these methods land here.
    
    // Method(_PTS, 1) match SSDT
    Method (_PTS, 1, NotSerialized)
    {
        If (CondRefOf(\RMCF.DPTS))
        {
            If (\RMCF.DPTS)
            {
                // enable discrete graphics
                If (CondRefOf(\_SB.PCI0.PEG0.PEGP._ON)) { \_SB.PCI0.PEG0.PEGP._ON() }
                // If (CondRefOf(\_SB.PCI0.PEGP.DGFX._ON)) { \_SB.PCI0.PEGP.DGFX._ON() }
            }
        }

        // call into original _PTS method
        ZPTS(Arg0)
    }
    
    
    // Method(_WAK, 1) match SSDT
    Method (_WAK, 1, NotSerialized)
    {
        // Take care of bug regarding Arg0 in certain versions of OS X...
        // (starting at 10.8.5, confirmed fixed 10.10.2)
        If (Arg0 < 1 || Arg0 > 5) { Arg0 = 3 }

        // call into original _WAK method
        Local0 = ZWAK(Arg0)

        If (CondRefOf(\RMCF.DPTS))
        {
            If (\RMCF.DPTS)
            {
                // disable discrete graphics
                If (CondRefOf(\_SB.PCI0.PEG0.PEGP._OFF)) { \_SB.PCI0.PEG0.PEGP._OFF() }
                // If (CondRefOf(\_SB.PCI0.PEGP.DGFX._OFF)) { \_SB.PCI0.PEGP.DGFX._OFF() }
            }
        }

        // return value from original _WAK
        Return (Local0)
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
