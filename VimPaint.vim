"An ASCII paint program completely integrated within vim

"Custom commands to initialize/end paint mode
command Paint call PaintInit()
command PaintQuit call PaintQuit()
"Command to crop the useless white spaces in the image
command -range=% PaintCrop call PaintCrop(<line1>,<line2>)

fu! PaintInit()
    "Declare a primary and secondary brush for this buffer
    call PaintRemapPrimaryBrush('*')
    call PaintRemapSecondaryBrush(' ')

    "Create mappings for moving around. Moving to an unexplored
    "region fills it with spaces
    nnoremap <silent> <Left> :call PaintMoveLeft()<CR>
    nnoremap <silent> <Right> :call PaintMoveRight()<CR>
    nnoremap <silent> <Up> :call PaintMoveUp()<CR>
    nnoremap <silent> <Down> :call PaintMoveDown()<CR>

    "Create mapping for changing the brushes
    "b is for primary brush, B for secondary
    nnoremap <expr> b ":call PaintRemapPrimaryBrush('".nr2char(getchar())."')<CR>"
    nnoremap <expr> B ":call PaintRemapSecondaryBrush('".nr2char(getchar())."')<CR>"

endfu


fu! PaintQuit()
    "Lots of unmapping to do
    unmap <Left>
    unmap <Right>
    unmap <Up>
    unmap <Down>

    unmap h
    unmap j
    unmap k
    unmap l

    unmap H
    unmap J
    unmap K
    unmap L

    unmap b
    unmap B
endfu

"Map h,j,k,l and H,J,K,L to the brushes

fu! PaintRemapPrimaryBrush(val)
    execute "nnoremap <silent> h :call PaintLeft('".a:val."')<CR>"
    execute "nnoremap <silent> j :call PaintDown('".a:val."')<CR>"
    execute "nnoremap <silent> k :call PaintUp('".a:val."')<CR>"
    execute "nnoremap <silent> l :call PaintRight('".a:val."')<CR>"
endfu


fu! PaintRemapSecondaryBrush(val)
    execute "nnoremap <silent> H :call PaintLeft('".a:val."')<CR>"
    execute "nnoremap <silent> J :call PaintDown('".a:val."')<CR>"
    execute "nnoremap <silent> K :call PaintUp('".a:val."')<CR>"
    execute "nnoremap <silent> L :call PaintRight('".a:val."')<CR>"
endfu


fu! PaintLeft(val)
    call PaintMoveLeft()
    execute "normal! r".a:val
endfu


fu! PaintRight(val)
    call PaintMoveRight()
    execute "normal! r".a:val
endfu


fu! PaintUp(val)
    call PaintMoveUp()
    execute "normal! r".a:val
endfu


fu! PaintDown(val)
    call PaintMoveDown()
    execute "normal! r".a:val
endfu


fu! PaintMoveLeft()
    normal! h
endfu


fu! PaintMoveRight()
    "Get the cursor position in cur, and the end of the line in eol
    let save_cursor = getcurpos()
    normal! $
    let eol = virtcol('.')
    call setpos('.', save_cursor)
    let cur = virtcol('.')

    if cur == eol
        normal! a 
    else
        normal! l
    endif
endfu


fu! PaintMoveUp()
    "Get the cursor position in cur
    let cur = virtcol('.')
    normal! k

    while virtcol('.') != cur
        normal! a 
    endwhile
endfu


fu! PaintMoveDown()
    "Get the cursor position in cur[lc], and the end of the file in eof
    let save_cursor = getcurpos()
    normal! G
    let eof = line('.')
    call setpos('.', save_cursor)
    let curl = line('.')
    let curc = virtcol('.')

    if curl == eof
        normal! o
        call setpos('.', save_cursor)
    endif

    normal! j

    while virtcol('.') != curc
        normal! a 
    endwhile
endfu


fu! PaintCrop(line1, line2)
    "Remove trailing spaces
    execute a:line1.','.a:line2.'s/\s*$//'

    let newline2 = a:line2
    "Crop the top
    execute "normal! ".a:line1."gg$"
    while col('.') == 1
        let newline2 = newline2 - 1
        normal! dd$
    endwhile
    "Crop the bottom
    execute "normal! ".newline2."gg$"
    while col('.') == 1
        let newline2 = newline2 - 1
        execute "normal! dd".newline2."gg$"
    endwhile

    "Algorithmically find the left indentation
    normal! $
    let newline2 = line('.')
    let left_indent = col('.')
    for i in range(a:line1-1,newline2-1)
        execute i.'/\S'
        let left_indent = (col('.') < left_indent) ? col('.') : left_indent
    endfor
    "Remove the left space
    if left_indent > 1
        execute a:line1.','.newline2."normal! 0".(left_indent-1)."x"
    endif
endfu

