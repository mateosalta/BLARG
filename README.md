BLARG
=====

Bluetooth Linux Automatic Rusticating Galimatias (bluecasting)

possible structure ~

![logic](https://raw.github.com/mateosalta/BLARG/master/blarg.jpg)

------

The objective of BLARG is to create a simple shell script for a kiosk computer, that auto sends a file once a Android device connects via bluetooth.

Commands so far:

    ---bt-device -l---
    
    hcitool con
    
    bluetooth-sendto --device=
    
    ---bt-obex---   

    ---bluez-test-adapter address---

that one gets the adapter addresses



research links:

http://askubuntu.com/questions/138522/how-do-i-run-a-script-when-a-bluetooth-device-connects

http://unix.stackexchange.com/questions/96693/connect-to-a-bluetooth-device-via-terminal

http://stackoverflow.com/questions/8130396/fast-way-to-check-many-bluetooth-devices-by-mac-address

------

- [x] Figure out basics
  - [x] loop or something
  - [x] magic to convert MAC address
  - [ ] add more checkboxes later
  - [x] ...
- [x] ...?
- [x] Profit!?
