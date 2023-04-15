function fish_prompt --description 'Write out the prompt'
    set laststatus $status
    echo -n -s (set_color --bold) (set_color -b 111) (set_color blue) (prompt_hostname)' '
    if not [ -w $PWD ]
        set_color 600
    else
        set_color 111
    end
    echo -n -s (get_git_status)
    if test $laststatus -eq 0
        echo -n -s (set_color -b 222)  ' ' (set_color --bold) (set_color magenta) (prompt_pwd) ' ' (set_color normal) (set_color 222)  (set_color normal) ' '
    else
        echo -n -s (set_color -b 400)  ' ' (set_color --bold) (set_color magenta) (prompt_pwd) ' ' (set_color normal) (set_color 400)  (set_color normal) ' '
    end
end

function get_git_status -d "Gets the current git status"
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)
    set -l ref (command git describe --tags --exact-match 2> /dev/null ; or command git symbolic-ref --short HEAD 2> /dev/null ; or command git rev-parse --short HEAD 2> /dev/null)
    set -l ref (echo $ref | string replace 'master' ' ' | string replace 'dev' ' ⎇ ')
    if command git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- :/ >/dev/null 2>&1
        set_color 962
    end
    if not [ -w $PWD ]
        set_color 600
    end
    if [ "$dirty" != "0" ]
      echo -n -s (set_color -b 730) '' (set_color normal) (set_color -b 730) (set_color black) $ref ' ' (set_color --bold) (set_color 730) 
    else
      echo -n -s (set_color -b 131) '' (set_color normal) (set_color -b 131) (set_color 777)   $ref ' ' (set_color --bold) (set_color 131)
    end
   end
end



