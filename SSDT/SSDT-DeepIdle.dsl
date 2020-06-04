//
// SSDT-DeepIdle.dsl
//
// Dell XPS 15 9560 
//
// This SSDT adds IOPMDeepIdleSupported to IOPMRootDomain
// (found at IOService:/AppleACPIPlatformExpert/IOPMrootDomain).
//
// credit to https://pikeralpha.wordpress.com/2017/01/12/debugging-sleep-issues/
// 
// Frok form darkhandz:
// https://github.com/darkhandz/XPS15-9550-Sierra/blob/master/DSDT-HotPatches/Patches/SSDT-DeepIDLE.dsl
// commit 0f65f2f57874b76c965abc5dd171643c94e834b6
//

DefinitionBlock("", "SSDT", 2, "hack", "DIDLE", 0)
{
    If (_OSI ("Darwin")) {
        Scope (\_SB) {
            Method (LPS0, 0, NotSerialized) {
                Return (One)
            }
        }

        Scope (\_GPE) {
            Method (LXEN, 0, NotSerialized) {
                Return (One)
            }
        }

        Scope (\) {
            Name (SLTP, Zero)

            Method (_TTS, 1, NotSerialized) {
                Store (Arg0, SLTP)
            }
        }
    }
}
