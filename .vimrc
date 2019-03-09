set shell=/usr/bin/bash

set noet

let g:syntastic_mode_map = {
			\ "mode": "active",
			\ "active_filetypes": [],
			\ "passive_filetypes": []}

let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_compiler_options = "-std=c99 -D_BSD_SOURCE -fms-extensions -Wall -Wextra -Wno-microsoft -Wno-missing-field-initializers"
let g:syntastic_c_include_dirs = [
			\ "vendor/sljit/sljit_src"]

set path+=vendor/sljit/sljit_src
