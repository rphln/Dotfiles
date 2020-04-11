function! tags#update() abort
  if empty(FugitiveGitDir())
    return
  endif

  if exists('s:tags_job_id')
    silent! call jobstop(s:tags_job_id)
  endif

  let s:tags_job_id = jobstart(["git", "ctags"], {'detach': v:true})
endfunction
