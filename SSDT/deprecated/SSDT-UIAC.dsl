//
// SSDT-UIAC.dsl
//
// MSI GL62M 7RD-223CN
//
// This SSDT provide a custom configuration for USBInjectAll.kext.
//
// Fork from RehabMan:
// https://github.com/RehabMan/OS-X-USB-Inject-All/raw/master/SSDT-UIAC-ALL.dsl
//
// Licensed under GNU General Public License v2.0
// https://github.com/RehabMan/OS-X-USB-Inject-All/blob/master/License.md

DefinitionBlock ("", "SSDT", 2, "hack", "UIAC-ALL", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            "8086_a12f", Package()
            {
                "port-count", Buffer() { 26, 0, 0, 0 },
                "ports", Package()
                {
                    "HS03", Package() // Left 01 USB2.0
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                    "HS04", Package() // Left 00 USB2.0
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 4, 0, 0, 0 },
                    },
                    "HS05", Package() // Left 02 Type-C USB2.0
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 5, 0, 0, 0 },
                    },
                    "HS06", Package() // Left 02 Type-C(Reverse) USB2.0
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },
                    "HS08", Package() // Right 00 USB2.0
                    {
                        "UsbConnector", 2,
                        "port", Buffer() { 8, 0, 0, 0 },
                    },
                    "HS10", Package() // Internal Bluetooth(Intel card)
                    // Partly working, the power switch broken
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 10, 0, 0, 0 },
                    },
                    "HS11", Package() // Internal Bison Camera, NB Pro
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 11, 0, 0, 0 },
                    },
                    /*
                     * Internal Realtek Card Reader (No driver)
                     * "HS12", Package()
                     * {
                     *    "UsbConnector", 255,
                     *    "port", Buffer() { 12, 0, 0, 0 },
                     * },
                     */
                    "SS02", Package() // Left 00 USB3.0
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 18, 0, 0, 0 },
                    },
                    "SS03", Package() // Left 01 USB3.0
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 19, 0, 0, 0 },
                    },
                    "SS05", Package() // Left 02 Type-C USB3.0
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 21, 0, 0, 0 },
                    },
                    "SS06", Package() // Left 02 Type-C(Reverse) USB3.0
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 22, 0, 0, 0 },
                    },
                },
            },
        })
    }
}
//EOF
