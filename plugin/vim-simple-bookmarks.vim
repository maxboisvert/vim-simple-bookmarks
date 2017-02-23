if exists("g:loaded_vim_simple_bookmarks")
  finish
endif
let g:loaded_vim_simple_bookmarks = 1

let g:vsb_file = get(g:, 'vsb_file', ".vim-simple-bookmarks")

fun! AddBookmark()
    let file   = expand('%')
    let line = getline('.')
    let line_number = line('.')

    call system('echo "' . file . ':' . line_number . '" >> ' . g:vsb_file)
endfun

fun! ListBookmarks()
    let bookmarks = []

    for bookmark in split(system('cat ' . g:vsb_file . ' 2>/dev/null'), '\n')
        let values = split(bookmark, ':')
        let filename = values[0]
        let lnum = values[1]
        let line = system('sed -n "' . lnum . 'p" < ' . filename)

        call add(bookmarks, { 'text': line, 'filename': filename, 'lnum': lnum })
    endfor

    call setqflist(bookmarks)
    copen
endfun

fun! ClearBookmarks()
    call system('rm ' . g:vsb_file)
endfun
