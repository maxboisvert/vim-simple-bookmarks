if exists("g:loaded_vim_simple_bookmarks")
  finish
endif
let g:loaded_vim_simple_bookmarks = 1

let g:vsb_file = get(g:, 'vsb_file', ".vim-simple-bookmarks")

fun! s:Init()
    call s:SimpleBookmarksPlugin()
endfun

fun! s:SimpleBookmarksPlugin()
    command SimpleBookmarksList call <SID>ListBookmarks()
    command SimpleBookmarksClear call <SID>ClearBookmarks()
    command SimpleBookmarksAdd call <SID>AddBookmark()

    fun! s:AddBookmark()
        let filename   = expand('%')
        let text = getline('.')
        let lnum = line('.')

        let data = {'filename': filename, 'text': text, 'lnum': lnum}

        call writefile([json_encode(data)], g:vsb_file, 'a')
    endfun

    fun! s:ListBookmarks()
        call setqflist(s:GetBookmarks())
        copen
        nnoremap <silent> <buffer> <cr> <cr>:cclose<cr>
        nnoremap <silent> <buffer> q :cclose<cr>
        nnoremap <silent> <buffer> dd :call <SID>DeleteBookmark()<cr>
    endfun

    fun! s:GetBookmarks()
        let bookmarks = []

        if !s:FileExists(g:vsb_file)
            return bookmarks
        endif

        for bookmark_json in readfile(g:vsb_file)
            call add(bookmarks, json_decode(bookmark_json))
        endfor

        return bookmarks
    endfun

    fun! s:ClearBookmarks()
        call setqflist([])
        call delete(g:vsb_file)
    endfun

    fun! s:DeleteBookmark()
        let lnum = line('.')

        call system('sed -i -e "' . lnum . 'd" ' . g:vsb_file)
        call s:ListBookmarks()
    endfun

    fun! s:FileExists(file)
        return filereadable(a:file)
    endfun
endfun

call s:Init()
