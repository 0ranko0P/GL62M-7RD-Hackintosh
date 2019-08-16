//
// SSDT-XPCM.dsl
//
// Inject plugin-type=1 on _PR.CPU0

// This is experimental to see how only injecting plugin-type with native CPU PM SSDTs
// works on various platforms.
//
// Results: OK on Haswell+, not so good on Ivy
// Notes:
//   iMac17,1 and MacBook9,1 do not have APSS/ACST/APLF/etc
//   others like MacBookPro12,x, MacBook11,x do have it, but it is possible they are not used
//   likely any HWP enabled SMBIOS does not have APSS/ACST/APLF/etc and does not need it
//   could be that any XCPM enabled SMBIOS needs only this plugin-type injection
//
// Newer KabyLake/KabyLake-R/CoffeeLake boards use _PR.PR00, or _PR.P000 as first CPU path.
// Adjust this code according to what you find for Processor objects in your own DSDT.

// Fork from: RehabMan 
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/hotpatch/SSDT-XCPM.dsl
// commit 75a574b66585339f720edca2710a1267908ba489
//
// Licensed under GNU General Public License v2.0
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/License.md

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "_XCPM", 0)
{
#endif
    Method(_PR.CPU0._DSM, 4)
    {
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        Return (Package()
        {
            "plugin-type", 1
        })
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
