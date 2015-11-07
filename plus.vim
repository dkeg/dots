" =============================================================================
" Filename: autoload/lightline/colorscheme/plus.vim
" Version: 0.0
" Author: itchyny
" License: MIT License
" Last Change: 2013/09/07 12:21:04.
" =============================================================================
let s:base03 = [ 0, 0 ]
let s:base02 = [ 0, 0 ]
let s:base01 = [ 8, 8 ]
let s:base00 = [ 7, 7]
let s:base0 = [ 8, 8 ]
let s:base1 = [ 253,253 ]
let s:base2 = [ 253, 253 ]
let s:base3 = [ 253, 253 ]
let s:yellow = [ 3, 3 ]
let s:orange = [ 222, 222 ]
let s:red = [ 1, 1 ]
let s:magenta = [ 5, 5 ]
let s:blue = [ 4, 4 ]
let s:cyan = [ 6, 6 ]
let s:green = [ 2, 2 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base2, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:base02, s:green ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base02, s:red ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base0, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base02 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base1 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:base02 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base01 ] ]

let g:lightline#colorscheme#plus#palette= lightline#colorscheme#flatten(s:p)
