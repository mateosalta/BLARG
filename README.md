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

------
###What can this be used for?

BLARG is orginally intended for use at a kiosk or a small computer installed in a public setting, the purpose being to distribute promotional files such as background walpaper, new song, a ongoing video series, or speach. Having a local place to recieve that material without using internet or data. It's here: get it now.

###Why a shell script?

Although the initial writing of BLARG was complex, and it seemed to complicated to detect multiple devices thus the name including "Galimatias". However; Writing it as a shell script allows for adding any command line tool to the functionality of the program with little coding skill, you can add a section at the begining to rsync data from a network drive then bluecast a file off of that, add a command to e-mail someone for every file sent, considering the flexibility the posibilites are endless.
