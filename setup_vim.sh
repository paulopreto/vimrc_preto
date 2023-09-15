#!/bin/bash

# Update and install vim
sudo apt update
sudo apt install vim curl build-essential python3-dev -y

# Install Vim-Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Write the provided .vimrc content to the user's .vimrc file
cat > ~/.vimrc <<EOF
" Inicializa o Vim-Plug (gerenciador de plugins)
call plug#begin()

" Temas e Personalizações Visuais
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navegação de Código e Busca
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/tagbar'

" Linting e Autocompletar
Plug 'ycm-core/YouCompleteMe'
Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8'

" NERDTree
Plug 'preservim/nerdtree'

" Snippet Management
Plug 'SirVer/ultisnips'

" Autocorreção e Formatação de Código
Plug 'dense-analysis/ale'

" Backup e Histórico
set backup
set undofile
set undodir=~/.vim/undo

" Histórico de Comandos e Pesquisas
set history=1000

" Finaliza a seção de plugins
call plug#end()

" Configurações do Tema
syntax enable
colorscheme dracula
let g:airline_theme='dracula'

" Configurações Gerais
set autoindent
set cursorline
set showmatch
set number
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set wildmenu
set t_Co=256

" Indicação Visual para Modos
set showmode

" Configurações de Python
au FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
au FileType python setlocal autoindent
au FileType python setlocal cursorline
au FileType python setlocal showmatch

" Atalhos e Comandos Personalizados
" (Você pode adicionar seus próprios comandos ou atalhos específicos de compilação/deploy aqui)
nnoremap <C-n> :NERDTreeToggle<CR>
EOF

# Ensure the directory for Vim-Plug exists
mkdir -p ~/.vim/plugged

# Ensure proper permissions for .vim directory
sudo chown -R $USER:$USER ~/.vim

# Install Vim plugins
vim +PlugInstall +qall

# Compile YouCompleteMe
sudo apt install cmake -y
cd ~/.vim/plugged/YouCompleteMe
python3 install.py

# Install flake8 for Python linting
pip3 install --user flake8

echo "All done! Vim is now set up with your configuration."
