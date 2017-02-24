# Vim Simple Bookmarks

## Installation

### Plug
`Plug 'maxboisvert/vim-simple-bookmarks'`

Or use your prefered way.

## Usage

### Add a bookmark
```
:AddBookmark
```

### List bookmarks
```
:ListBookmarks
```

This will open the bookmarks list. Press enter to go to a bookmark.

### Delete bookmarks

press `dd` when a bookmark is selected in the list.

```
:ClearBookmarks
```

## Options

```VimL
let g:vsb_file = '.vim-simple-bookmarks'
```

## Mapping

Add this to your .vimrc

```
nnoremap <Leader>m :AddBookmark<CR>
nnoremap <Leader>n :ListBookmarks<CR>
```

## License

Copyright (c) 2016 Maxime Boisvert.
This program is licensed under the [GPLv3 license][gpl].
[gpl]: http://www.gnu.org/copyleft/gpl.html
