//
// SSDT-PNLF.dsl
//
// Adding PNLF device for WhateverGreen.kext and others.
// This is a modified PNLF version originally taken from RehabMan/OS-X-Clover-Laptop-Config repository:
// https://raw.githubusercontent.com/RehabMan/OS-X-Clover-Laptop-Config/master/hotpatch/SSDT-PNLF.dsl
// Rename GFX0 to anything else if your IGPU name is different.
//
// Licensed under GNU General Public License v2.0
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/License.md

DefinitionBlock("", "SSDT", 2, "hack", "_PNLF", 0)
{
    External(_SB.PCI0.GFX0, DeviceObj)

    Scope(_SB.PCI0.GFX0)
    {
        OperationRegion(RMP3, PCI_Config, 0, 0x14)
    }

    // For backlight control
    Device(_SB.PCI0.GFX0.PNLF)
    {
        Name(_ADR, Zero)
        Name(_HID, EisaId("APP0002"))
        Name(_CID, "backlight")
        // _UID is set depending on PWMMax to match profiles in WhateverGreen.kext Info.plist
        // 14: Sandy/Ivy 0x710
        // 15: Haswell/Broadwell 0xad9
        // 16: Skylake/KabyLake 0x56c (and some Haswell, example 0xa2e0008)
        Name(_UID, 16)
        Name(_STA, 0x0B)

        Field(^RMP3, AnyAcc, NoLock, Preserve)
        {
            Offset(0x02), GDID,16,
            Offset(0x10), BAR1,32,
        }

        // IGPU PWM backlight register descriptions:
        //   LEV2 not currently used
        //   LEVL level of backlight in Sandy/Ivy
        //   P0BL counter, when zero is vertical blank
        //   GRAN see description below in INI1 method
        //   LEVW should be initialized to 0xC0000000
        //   LEVX PWMMax except FBTYPE_HSWPLUS combo of max/level (Sandy/Ivy stored in MSW)
        //   LEVD level of backlight for Coffeelake
        //   PCHL not currently used
        OperationRegion(RMB1, SystemMemory, BAR1 & ~0xF, 0xe1184)
        Field(RMB1, AnyAcc, Lock, Preserve)
        {
            Offset(0x48250),
            LEV2, 32,
            LEVL, 32,
            Offset(0x70040),
            P0BL, 32,
            Offset(0xc2000),
            GRAN, 32,
            Offset(0xc8250),
            LEVW, 32,
            LEVX, 32,
            LEVD, 32,
            Offset(0xe1180),
            PCHL, 32,
        }

        // INI1 is common code used by FBTYPE_HSWPLUS and FBTYPE_CFL
        Method(INI1, 1)
        {
            // INTEL OPEN SOURCE HD GRAPHICS, INTEL IRIS GRAPHICS, AND INTEL IRIS PRO GRAPHICS PROGRAMMER'S REFERENCE MANUAL (PRM)
            // FOR THE 2015-2016 INTEL CORE PROCESSORS, CELERON PROCESSORS AND PENTIUM PROCESSORS BASED ON THE "SKYLAKE" PLATFORM
            // Volume 12: Display (https://01.org/sites/default/files/documentation/intel-gfx-prm-osrc-skl-vol12-display.pdf)
            //   page 189
            //   Backlight Enabling Sequence
            //   Description
            //   1. Set frequency and duty cycle in SBLC_PWM_CTL2 Backlight Modulation Frequency and Backlight Duty Cycle.
            //   2. Set granularity in 0xC2000 bit 0 (0 = 16, 1 = 128).
            //   3. Enable PWM output and set polarity in SBLC_PWM_CTL1 PWM PCH Enable and Backlight Polarity.
            //   4. Change duty cycle as needed in SBLC_PWM_CTL2 Backlight Duty Cycle.
            // This 0xC value comes from looking what OS X initializes this
            // register to after display sleep (using ACPIDebug/ACPIPoller)
            If (0 == (2 & Arg0))
            {
                Local5 = 0xC0000000
                ^LEVW = Local5
            }
            // from step 2 above (you may need 1 instead)
            If (4 & Arg0)
            {
                ^GRAN = 0
            }
        }
    }
}
