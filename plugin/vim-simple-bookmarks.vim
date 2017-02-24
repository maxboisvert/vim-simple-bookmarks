if exists("g:loaded_vim_simple_bookmarks")
  finish
endif
let g:loaded_vim_simple_bookmarks = 1

let g:vsb_file = get(g:, 'vsb_file', ".vim-simple-bookmarks")

fun! s:Init()
    call s:SimpleBookmarksPlugin()
endfun

fun! s:SimpleBookmarksPlugin()
    command ListBookmarks call <SID>ListBookmarks()
    command ClearBookmarks call <SID>ClearBookmarks()
    command AddBookmark call <SID>AddBookmark()

    fun! s:AddBookmark()
        let file   = expand('%')
        let line = getline('.')
        let line_number = line('.')

        call system('echo "' . file . ':' . line_number . '" >> ' . g:vsb_file)
    endfun

    fun! s:ListBookmarks()
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
        nnoremap <silent> <buffer> <cr> <cr>:cclose<cr>
        nnoremap <silent> <buffer> dd :call <SID>DeleteBookmark()<cr>
        "nnoremap <buffer> <Esc> :cclose<CR>
    endfun

    fun! s:ClearBookmarks()
        call system('rm ' . g:vsb_file)
    endfun

    fun! s:DeleteBookmark()
        let lnum = line('.')

        call system('sed -i -e "' . lnum . 'd" ' . g:vsb_file)
        call s:ListBookmarks()
    endfun
endfun

call s:Init()
