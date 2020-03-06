if exists('g:flatyank_loaded')
  finish
endif

let g:flatyank_loaded = 1

command! -register FlatYank call s:flat_yank('<reg>')
vnoremap <silent> <Plug>(flatyank) :<C-u>FlatYank<CR>

function! s:visual_select()
  let regTmp = @a
  silent normal! gv"ay
  let selectText = @a
  let @a = regTmp
  unlet regTmp
  return selectText
endfunction

function! s:flat(str)
  let str = a:str
  let str = substitute(str, '\n',' ','g')
  let str = substitute(str, '\s\+', ' ','g')
  let str = substitute(str, "'", "''",'g')
  let str = trim(str)
  return str
endfunction

function! s:flat_yank(reg)
  if a:reg
    let l:reg = '@'.a:reg
  else
    let l:reg = '@"'
  endif

  let str = s:visual_select()
  let str = s:flat(str)
  exec ('let ' . l:reg . ' = ''' . str . '''')
endfunction

