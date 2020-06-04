//
// SSDT-XOSI.dsl
//
// Override for host defined _OSI to handle "Darwin"...
//
// Fork from: RehabMan 
// https://raw.githubusercontent.com/RehabMan/OS-X-Clover-Laptop-Config/master/hotpatch/SSDT-XOSI.dsl
// commit 8b865e1e3ca4b1947cc9a4bf177bbbccf6e4058b
//
// Licensed under GNU General Public License v2.0
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/License.md

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "_XOSI", 0)
{
#endif
    // All _OSI calls in DSDT are routed to XOSI...
    // As written, this XOSI simulates "Windows 2015" (which is Windows 10)
    // Note: According to ACPI spec, _OSI("Windows") must also return true
    //  Also, it should return true for all previous versions of Windows.
    Method(XOSI, 1) {
        If (_OSI ("Darwin")) {
            // simulation targets
            // source: (google 'Microsoft Windows _OSI')
            // https://docs.microsoft.com/en-us/windows-hardware/drivers/acpi/winacpi-osi
            Local0 = Package()
            {
                "Windows",              // generic Windows query
                // "Windows 2013",         // Windows 8.1/Windows Server 2012 R2
                "Windows 2015",         // Windows 10/Windows Server TP
                //"Windows 2016",       // Windows 10, version 1607
                //"Windows 2017",       // Windows 10, version 1703
                //"Windows 2017.2",     // Windows 10, version 1709
                //"Windows 2018",       // Windows 10, version 1803
            }
            Return (Ones != Match(Local0, MEQ, Arg0, MTR, 0, 0))
        } Else {
            Return (_OSI (Arg0))
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
