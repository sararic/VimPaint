# VimPaint

Use Vim to create nice ascii art.

## Installation

Download `VimPaint.vim`, and add the following lines to your `.vimrc`:
```vim
"Source VimPaint
source /Full/path/to/VimPaint.vim
```
(replace `/Full/path/to/VimPaint.vim` with the path to the downloaded file)

## Commands

`VimPaint` has the following Command Mode commands:

* ```
  :Paint
  ``` 
  Start `VimPaint`

* ```
  :PaintQuit
  ``` 
  Quit `VimPaint`

* ```
  :PaintCrop
  ``` 
  Crop the drawing you've made: removes trailing spaces, adjusts
  the image on the left, and removes empty lines above and below.

  This command can be used on a line range or a selection in Visual
  Mode. By default, it acts on the whole buffer.

## Normal Mode

This is where the drawing happens. `VimPaint` does not use the Insert 
Mode at all. You have the following key bindings available:

* `hjkl`: Draw with the main brush.
* `HJKL`: Draw with the secondary brush.
* `Arrow keys`: Move around the canvas without drawing anything.
* `b<char>`: Change the main brush to `<char>`
  (by default, '*' is used.)
* `B<char>`: Change secondary brush to `<char>`
  (by default, whitespace is used.) 

```
########   ##      ##          ###   ##########  ###     ###    #####
########   ####    ##          ###   ##########  ####    ###    #####
##         ######  ##          ###   ##      ##   #####  ###    #####
##         ## #### ##          ###   ##      ##    #########     ###
########   ##  ######          ###   ##      ##      #######     ###
########   ##   #####   ###    ###   ##      ##          ###
##         ##    ####   #####  ###   ##      ##          ###    #####
########   ##     ###   ##########   ##########          ###    #####
########   ##      ##    #########   ##########          ###    #####
```