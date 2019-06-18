set laststatus=2

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let g:lightline#gitdiff#indicator_added = "+"
let g:lightline#gitdiff#indicator_deleted = "-"
let g:lightline#gitdiff#indicator_modified = "~"

let g:lightline = {
    \ 'colorscheme': 'palenight',
    \ 'separator': {'left': "", 'right': ''},
    \ 'subseparator': { 'left': '', 'right': ''},
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'LightlineReadonly', 'filename', 'modified' ] ]
    \ },
    \ }

let g:lightline.component_function = {
    \   'gitbranch': 'LightlineFugitive',
    \   'LightlineReadonly': 'LightlineReadonly',
    \   'cwd': 'LightlineCwd',
    \   'cocstatus': 'coc#status',
    \ }

let g:lightline.component = {
    \   'statusdiagnostic': '%{StatusDiagnostic()}'
    \ }

let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'gitbranch', 'gitdiff' ], [ 'statusdiagnostic' ], [ 'cwd', 'relativepath' ] ]
    \ }

let g:lightline.component_expand = { 'gitdiff': 'lightline#gitdiff#get' }

function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction

function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction

function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return 'E0 W0' | endif

    let msgs = []

    call add(msgs, 'E' . get(info, 'error', 0))
    call add(msgs, 'W' . get(info, 'warning', 0))
    return join(msgs, ' ')
endfunction

function! LightlineCwd() abort
    return getcwd()
endfunction
