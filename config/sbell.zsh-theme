# This is a small modification of the blinks zsh theme:
# https://github.com/blinks
# Respects ~/.term-light for dark/light mode (checked once at shell startup)

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{green}%}±%{%f%k%b%}"
  else
    echo ' '
  fi
}

if [[ -f ~/.term-light ]]; then
  _bg="white"
else
  _bg="black"
fi

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{$_bg}%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT='%{%f%k%b%}
%{%K{'"$_bg"'}%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{'"$_bg"'}%}%~%{%B%F{green}%}$(git_prompt_info)%E%{%f%k%b%}
%{%K{'"$_bg"'}%}$(_prompt_char)%{%K{'"$_bg"'}%} %#%{%f%k%b%} '

#RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'
