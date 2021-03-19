" ------------------------------------------------------------------------------
" # Vimrc
" ------------------------------------------------------------------------------
" # This is my parent vimrc config, where I setup my defaults and source
" # all of my plugins and config files using a plugin called Sourcery
" # For more info, see https://github.com/jesseleite/vim-sourcery


" ------------------------------------------------------------------------------
" # Sourcing
" ------------------------------------------------------------------------------

" Source plugins
call plug#begin()
  source ~/.dotfiles/vim/plugins.vim
call plug#end()

let g:sourcery#annotation_types = [
  \ 'Mappings',
  \ 'Config',
  \ 'Highlights',
  \ ]

" Initialize sourcery
call sourcery#source_path('colors')
call sourcery#init()
