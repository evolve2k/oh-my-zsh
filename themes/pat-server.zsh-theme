grey='\e[0;90m'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$grey%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$grey%}) %{$fg[yellow]%}x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$grey%})"

function pat_prompt {
  (( spare_width = ${COLUMNS} ))
  prompt=" "

  branch=$(current_branch)
  path_size=${#PWD}
  branch_size=${#branch}
  
  if [[ ${#branch} -ne 0 ]]; then
    (( branch_size = branch_size + 4 ))
    if [[ -n $(git status -s 2> /dev/null) ]]; then
      (( branch_size = branch_size + 2 ))
    fi
  fi
  
  (( spare_width = ${spare_width} - (${path_size} + ${branch_size}) ))

  while [ ${#prompt} -lt $spare_width ]; do
    prompt=" $prompt"
  done
  
  prompt="%{%F{magenta}%}$PWD$prompt$(git_prompt_info)"
  
  echo $prompt
}

setopt prompt_subst

PROMPT='
%n@%m [%t]
$(pat_prompt)
%(?,%{%F{magenta}%},%{%F{red}%})>%{$reset_color%} '
