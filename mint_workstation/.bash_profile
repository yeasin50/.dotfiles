# ~/.bash_profile

# Source .bashrc first
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

## bash theme
function prompt_command() {
    local git_branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    local git_dirty=$(git status --porcelain 2>/dev/null)
    local python_env=""

    if [[ -n "$VIRTUAL_ENV" ]]; then
        python_env="($(basename "$VIRTUAL_ENV")) "
    fi

    # First line: user@host and directory, slightly dimmed
    local line1="\[\e[1;32m\]\u\[\e[0m\]@\[\e[1;37m\]\h \[\e[0;36m\]\w\[\e[0m\]"

    # Small gap for breathing space
    local line_gap="\n"

    # Second line: Git branch + Python venv + prompt symbol
    local line2=""
    if [[ -n "$git_branch" ]]; then
        if [[ -n "$git_dirty" ]]; then
            line2+="[\[\e[1;31m\]$git_branch\[\e[0m\]] "  # red if dirty
        else
            line2+="[\[\e[1;32m\]$git_branch\[\e[0m\]] "  # green if clean
        fi
    fi
    line2+="$python_env\[\e[1;32m\]❯ \[\e[0m\]"

    PS1="$line1$line_gap$line2"
}

PROMPT_COMMAND=prompt_command


# Completion scripts
[ -f /home/yeasin/.dart-cli-completion/bash-config.bash ] && . /home/yeasin/.dart-cli-completion/bash-config.bash || true



eval "$(zoxide init --cmd cd bash)"
