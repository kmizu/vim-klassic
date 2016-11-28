vim-klassic
=========

This is a "bundle" for Vim that builds off of the initial Klassic plugin modules.

##Installation

You really should be using Tim Pope's [Pathogen](https://github.com/tpope/vim-pathogen) module for Vim (http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen) if you're going to clone this repository because, well... you should.

###Vundle
Alternatively, you can use [Vundle](https://github.com/gmarik/vundle) to
manage your plugins.

If you have Vundle installed, simply add the following to your .vimrc:

```vim
Plugin 'kmizu/vim-klassic'
```

and then run

```vim
:PluginInstall
```

to install it.

##Sorting of import statements
    :SortScalaImports

There are different modes for import sorting available. For details, please
consult the vimdoc help with

    :help :SortScalaImports
