# cubeRotate
A lua script for ComputerCraft that rotates a 3D cube on a monitor.

## Installation
Copy and paste the code from cubeRotate.lua OR run the following command:\
```shell
wget https://raw.githubusercontent.com/ddannyll/cubeRotate/main/cubeRotate.lua cubeRotate.lua
```

## Usage
Ensure that you have at least a 2 x 2 monitor connected to the computer and run the following command:
`cubeRotate.lua`
- Note: the program is able to run on different sizes of monitors however you may need to edit `cubeRotate.lua` and adjust the `scale` variable. 

## Configuration
Inside `cubeRotate.lua`, the following variables can be changed to obtain a different rotating cube:
- `scale`
- `zoffset`
- `MonBackColor`
- `MonColor`

- Note: An advanced computer is required to change monitor colors. 


## Screenshots
![RotatingCube](./images/rotate.gif)

## Acknowledgements 
The math involved in this script was inspired by [uper](https://youtu.be/kBAcaA7NAlA)
