# Raspberry Pi OTA Mechanism

A mechanism to update Raspberry Pi OS image by Pi itself. To achieve updating Raspberry Pi software without removing SD card.

## Instructions

**_WARNING: This project just an idea and only test on RaspiOS from 2021-03-04 to 2021-05-07. Do not try this instructions on your important OS image_.**

Copy this project and Raspberry Pi OS image to Raspberry Pi.
Run the following commands:

```
$ cp <your raspios.img> rasberrypi-ota/
$ cd raspberrypi-ota
$ sudo ./ota.sh
```

It will takes much times. Please wait and do not poweroff. Suggest using [debug port](https://elinux.org/RPi_Serial_Connection) to monitor the progress.

<img src="https://user-images.githubusercontent.com/22016807/123514861-8ac60000-d6c7-11eb-90b3-db4f32490ce8.png" alt="uart" width="720"/>

## Flowchart
<img src="https://user-images.githubusercontent.com/22016807/123514610-6b7aa300-d6c6-11eb-92a3-0c774924523f.png" alt="flowchart" width="720"/>


### [OTA (Over-the-Air)](https://en.wikipedia.org/wiki/Over-the-air_programming)
Over-the-air programming (OTA programming) refers to various methods of distributing new software, configuration settings, and even updating encryption keys to devices.

### [Initrd (Initial ramdisk)](https://en.wikipedia.org/wiki/Initial_ramdisk)
Initrd (initial ramdisk) is a scheme for loading a temporary root file system into memory, which may be used as part of the Linux startup process.

### [Busybox](https://en.wikipedia.org/wiki/BusyBox)
BusyBox is a software suite that provides several Unix utilities in a single executable file.
