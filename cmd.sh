#!/bin/bash
set -e -x

git submodule add git://github.com/tpope/vim-fugitive.git vim/bundle/fugitive && git submodule init && git submodule update
git submodule add git://github.com/docunext/closetag.vim.git vim/bundle/closetag && git submodule init && git submodule update
git submodule add git://github.com/scrooloose/nerdcommenter.git vim/bundle/nerdcommenter && git submodule init && git submodule update
git submodule add git://github.com/altercation/vim-colors-solarized.git vim/bundle/solarized && git submodule init && git submodule update
git submodule add git://github.com/scrooloose/syntastic.git vim/bundle/syntastic && git submodule init && git submodule update
git submodule add git://github.com/vim-scripts/ShowMarks.git vim/bundle/showmarks && git submodule init && git submodule update
git submodule add git://github.com/tsaleh/vim-matchit.git vim/bundle/matchit && git submodule init && git submodule update
git submodule add git://github.com/ervandew/supertab.git vim/bundle/supertab && git submodule init && git submodule update
git submodule add git://github.com/Lokaltog/vim-easymotion.git vim/bundle/easymotion && git submodule init && git submodule update
git submodule add git://github.com/tpope/vim-surround.git vim/bundle/surround && git submodule init && git submodule update
git submodule add git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex vim/bundle/latex && git submodule init && git submodule update
git submodule add git://github.com/Lokaltog/vim-powerline.git vim/bundle/powerline && git submodule init && git submodule update
git submodule add git://github.com/majutsushi/tagbar.git vim/bundle/tagbar && git submodule init && git submodule update
git submodule add git://github.com/scrooloose/nerdtree.git vim/bundle/nerdtree && git submodule init && git submodule update
git submodule add git://github.com/vim-scripts/SearchComplete.git vim/bundle/searchcomplete && git submodule init && git submodule update
git submodule add git://github.com/derekwyatt/vim-fswitch.git vim/bundle/fswitch && git submodule init && git submodule update
git submodule add git://github.com/vitaly/vim-gitignore.git vim/bundle/gitignore && git submodule init && git submodule update
git submodule add git://github.com/vim-scripts/YankRing.vim/.git vim/bundle/yankring && git submodule init && git submodule update
git submodule add git://github.com/sjl/gundo.vim.git vim/bundle/gundo && git submodule init && git submodule update
git submodule add git://github.com/kien/ctrlp.vim.git vim/bundle/ctrlp && git submodule init && git submodule update
git submodule add git://github.com/kien/tabman.vim.git vim/bundle/tabman && git submodule init && git submodule update
