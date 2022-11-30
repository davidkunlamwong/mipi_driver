# mipi_driver
Driver for MIPI camera on Jetson AGX with L4T 32.5.1 (Jetpack 4.5.1)
- IMX 296
- IMX 392

## Functional if performing full flash:
1.  Modify jetson_vars.sh: specify path to local repo, your PC username and password
2.  run install_gcc_7.3.1.sh
3.  run download_xavier_32.5.1.sh
4.  run install_xavier_32.5.1.sh
5.  modify tegra194-p2888-0001-p2822-0000.dts to install the correct device tree
6.  run sync.sh
7.  run m.sh
8.  Boot AGX into recovery mode
9.  run f.sh
10.  Connect AGX to screen and set up user
11.  Use SDK Manager but *DO NOT FLASH OS*, only install Jetson SDK

## vcmipidemo.c
Source file for demo programme from visual components, fixed color issues. 
