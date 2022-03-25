""" Vim-Plug
call plug#begin()

" Aesthetics - Main
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Functionalities
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-abolish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'chrisbra/Colorizer'
Plug 'KabbAmine/vCoolor.vim'
Plug 'vim-scripts/loremipsum'
Plug 'metakirby5/codi.vim'
Plug 'dkarter/bullets.vim'
Plug 'sheerun/vim-polyglot'
Plug 'eliba2/vim-node-inspect'

" Entertainment
Plug 'adelarsq/vim-hackernews'

call plug#end()

""" Theme
colorscheme gruvbox
let g:airline_theme='bubblegum'
let g:quickui_color_scheme = 'gruvbox'

""" General configurations
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set wrap breakindent
set encoding=utf-8
set number
set title
set spell spelllang=en_us,it

""" Coc Configurations

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-sh',
  \ 'coc-css',
  \ 'coc-rls',
  \ 'coc-html',
  \ 'coc-gitignore',
  \ 'coc-marketplace',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

"" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

""" NERDTree configurations
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

""" NERDCommenter configurations
let g:NERDCreateDefaultMappings = 0

""" Airline configurations
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

""" TagBar
let g:tagbar_width = 30
let g:tagbar_iconchars = ['↠', '↡']

""" fzf-vim
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'Type'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Character'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

""" Filetype-Specific Configurations

" HTML, XML, Jinja
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

" Markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2

""" Custom Functions

function! s:showDocumentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

function! s:toggleThemeBackground()
    if &bg ==# 'light'
        set bg=dark
    else
        set bg=light
    endif
endfunction

let g:term_buf = 0
let g:term_win = 0
function! s:openTerminal(height)
    botright new
    exec "resize " . a:height
    try
        exec "buffer " . g:term_buf
    catch
        call termopen($SHELL, {"detach": 0})
        let g:term_buf = bufnr("")
        set nonumber
        set norelativenumber
        set signcolumn=no
    endtry
    startinsert!
endfunction


function! s:checkBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

""" Memo
" :ColorToggle
" :HackerNews best
" :Goyo

""" Custom commands

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:ToggleThemeBackground` command to toggle the theme background (light/dark).
command! -nargs=0 ToggleThemeBackground :call <SID>toggleThemeBackground()

" Add `:ChooseTheme` command to change the current theme.
command! -nargs=0 ChooseTheme :Colors

""" Custom Mappings

let mapleader=","

" Remove the highlighting.
nmap <silent> <leader><leader> :noh<CR>

" Buffer mappings.
nmap <C-d> :bp<bar>sp<bar>bn<bar>bd<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" Toggle the Nerd tree.
nmap <silent><C-t> :NERDTreeToggle<CR>

" Toggle the tag bar.
nmap <silent><C-b> :TagbarToggle<CR>

" Search a file in the file system.
nmap <silent><C-f> :Files<CR>

" Open a nvim terminal.
nmap <A-t> :call <SID>openTerminal(12)<CR>

" Close the current nvim terminal.
tmap <silent><Esc> <C-\><C-n>:q!<CR>

" Save the current buffer.
nmap <C-s> :w<CR>

" Comment one or more lines of code with visual mode.
vmap <C-\> <plug>NERDCommenterToggle
nmap <C-\> <plug>NERDCommenterToggle

" Node inspect mappings.
nmap <silent><leader>br :NodeInspectRun<CR>
nmap <silent><leader>bs :NodeInspectStop<CR>
nmap <silent><leader>bb :NodeInspectToggleBreakpoint<CR>
nmap <silent><leader>ba :NodeInspectRemoveAllBreakpoints<CR>
nnoremap <silent><leader>bj :NodeInspectStepOver<CR>
nnoremap <silent><leader>bl :NodeInspectStepInto<CR>
nnoremap <silent><leader>bh :NodeInspectStepOut<CR>

" Window mappings.
nmap <leader>h <C-w>s<C-w>w<CR>
nmap <leader>v <C-w>v<C-w>w<CR>
nmap <leader>c <C-w>c<CR>
nmap <leader>n :vne<CR>
nmap <M-S-Up> <C-w>+<CR>
nmap <M-S-Down> <C-w>-<CR>
nmap <M-S-Left> <C-w><<CR>
nmap <M-S-Right> <C-w>><CR>
nmap <M-Up> <C-w>k<CR>
nmap <M-Down> <C-w>j<CR>
nmap <M-Left> <C-w>h<CR>
nmap <M-Right> <C-w>l<CR>

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent><leader>s <Plug>(coc-range-select)
xmap <silent><leader>s <Plug>(coc-range-select)

" Remap for rename current word.
nmap <leader>r <Plug>(coc-rename)

" Remap for rename current file.
nmap <leader>rr :CocCommand workspace.renameCurrentFile<CR>

" Organize imports of the current buffer.
nmap <silent><leader>o :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Format code.
map <leader>f :call CocAction('format')<CR>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>af  <Plug>(coc-fix-current)

" GoTo code navigation.
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
nmap gt <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)

" Show documentation in preview window.
nmap <leader>d :call <SID>showDocumentation()<CR>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Shaw extensions marketplace.
nnoremap <silent><nowait> <space>m  :<C-u>CocList marketplace<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>checkBackSpace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <M-CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
