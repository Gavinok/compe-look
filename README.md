# compe-look

Provides dictionary completion for compe using the Unix program look

<!-- ![demo](images/compe-look.gif) -->

## Install

You also need to install the Unix program `look` chances are you already have it installed.

### Using plug:

```vim
Plug 'nvim-lua/plenary.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'Gavinok/compe-look'
```

By default compe-look uses vim's `dictionary` for completion.

to set this in your vimrc
```vim
set dictionary=/usr/share/dict/words
```

in lua
```vim
vim.o.dictionary = "/usr/share/dict/words"
```

Since `look` only allows for 2 dictionaries the first entry in vim's dictionary
is used if anyone has a solution or suggestions please create a PR or issue

### Using Packer:

```lua
return require("packer").startup(
 function(use)
 	use "hrsh7th/nvim-compe" --completion
 	use {'Gavinok/compe-look', requires = 'nvim-lua/plenary.nvim', requires = 'hrsh7th/nvim-compe'}
 end
)
```

## Usage 

Make sure that compe-nvim is loaded.

```vim
let g:compe.source.look = v:true
```

```clojure
((. (require :compe) :setup) 
 {:source 
   {:look true})
```

```lua
require'compe'.setup {
  source = {
      look = true
    }
}
```

## License

MIT
