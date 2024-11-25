" set notermguicolors
" colorscheme vim
" hi Visual ctermfg=none ctermbg=242

:lua require('plugins')

" No side-bar
set scl=no

" Scroll when cursor is close to edge
set scrolloff=10

" Disable accidentally inputting escape sequence on rebound windows key for <>|
imap <D-'> '
imap <D-Bar>
imap <D-.> <Nop>
imap <D-k> <Nop>
imap <S-D-Space> <Nop>

" Remember cursor position of buffers
set viminfo^=%

set laststatus=3

set nowrap
set spelllang=en

" Replace statusbar with command
set cmdheight=0

" Double tap esc to de-highlight
nnoremap <esc><esc> :silent! nohls \| ccl<CR>

" Space to save
nnoremap <Space> :w<CR>

" Changing buffer should also change working directory
autocmd BufEnter * silent! lcd %:p:h

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" Resize splits on window resize
autocmd VimResized * wincmd =
set equalalways

" hi Pmenu ctermfg=14 ctermbg=NONE
" hi PmenuSel ctermfg=11 ctermbg=NONE
" hi SignColumn ctermbg=NONE
" hi VertSplit ctermbg=NONE guibg=NONE cterm=NONE ctermfg=6
" hi Search ctermbg=NONE ctermfg=1
" hi Keyword ctermfg=2
" hi Type ctermfg=14
" hi MatchParen cterm=none ctermfg=3 ctermbg=none
" hi Constant ctermfg=4

" Jump to last known position when opening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Default to 4-width spaces on tab
set tabstop=4
set shiftwidth=4
set expandtab

" Completion UI settings
set completeopt=menu,menuone,noselect

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>

" Lumina specific settings
au BufReadPost *.lm :setf lumina
au BufReadPost *.lm :set formatoptions=cro
au BufReadPost *.lm :set tabstop=2
au BufReadPost *.lm :set shiftwidth=2

" Switch panes with just ctrl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Format on save
" autocmd BufWritePre *.rs lua vim.lsp.buf.format({async=false})
" autocmd BufWritePre *.hs lua vim.lsp.buf.format({async=false})
" autocmd BufWritePre *.elm lua vim.lsp.buf.format({async=false})

" For some reason this bind doesn't work when I do it in lua
nnoremap m :Ranger<CR>

" This prevents the statusbar from randomly disapearing a bit when you enter insert mode
set noshowmode

" Statusline
" let g:lightline = {
"       \ 'colorscheme': 'powerline',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'readonly', 'abrfilepath', 'modified', 'helloworld' ] ]
"       \ },
"       \ 'component_function': {
"       \   'abrfilepath': 'LightLineFilename'
"       \ },
"       \ }

" function! LightLineFilename()
" 	let name = ""
" 	let subs = split(expand('%:p'), "/") 
" 
"     if len(subs) == 0
"         return ""
"     endif
" 
"     if len(subs) > 1 
"         if subs[0] == "home" && subs[1] == expand("$USERNAME")
"             let subs = ["~"] + subs[2:]
"         endif
"     endif
" 
"     if len(subs) > 9
"         let subs = subs[0:4] + ["..."] + subs[-3:-1]
"     endif
" 
"     let joined = join(subs, "/")
" 	
"     if joined[0] != "~" 
"         let joined = "/" . joined
"     endif
" 
"     return joined
" endfunction

" Solve auto-pair conflicts with Alt-Gr keyboards by unbinding everything
let g:AutoPairsShorcutToggle = ''
let g:AutoPairsFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsAutoParisShortcutBackInsert = ''
