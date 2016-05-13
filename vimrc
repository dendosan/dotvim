execute pathogen#infect()
syntax on
filetype plugin indent on

function! Carousel()
	for theme in split(globpath(&runtimepath, 'colors/*.vim'), '\n')
		let t = fnamemodify(theme, ':t:r')
		try
			execute 'colorscheme '.t
			echo t
		catch
		finally
		endtry
		sleep 4
		redraw
	endfor
endfunction

map <silent> <Leader>tc :call Carousel()<cr>

