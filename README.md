# Cpu-Ckb
Shows cpu usage in rgb using ckb on corsair rgb keyboard.

[![Alt text](https://img.youtube.com/vi/5cb-1PmFOvo/0.jpg)](https://www.youtube.com/watch?v=5cb-1PmFOvo)

## Installation 
First thing first you'll need to install [CKB](https://github.com/ckb-next/ckb-next) from their github page.

Then go on and install [lm-sensors](https://wpitchoune.net/psensor/) and configure them as instructed.

Next copy [ckb-next.conf](ckb-next.conf) into the CKB defalut configuration dir:

`~/.config/ckb-next/`

The new configuration can be found under the _custom_ voice. 

Finally start the script with:

`bash cpu_ckb.sh`

You can even add it to your startup applications as explained in [here](https://help.ubuntu.com/community/AddingProgramToSessionStartup).

## Color coding
There are three main processes defining the colors:

1. The numbers 1 to 9 on the numpad change color based on the cpu usage.
2. One of the numers 1 to 9 will be colored white. This number is indicative of the percentage of cpu usage on a tens scale.
3. The sorrounding buttons are colored based on the cpu temperature.

![img](imgs/color_map.jpg)

Number one and two work on the red part while number three on the green part.

## Customizing

### Adding new colors
The colors are referenced in the _cs_ array in line 8 of the [bash script](cpu_ckb.sh). The array contains 5 colors (c1 to c5) sorted from green to red; you can add as many shades as you like as long as you insert them in the array.

### Setting minumum cpu vars
There are to variables controlling the minimum cpu temperature and usage which are used to define a more precise range. 

Feel free to de/increase them if you wish but be sure to keep them grather than 0 and less than 100.