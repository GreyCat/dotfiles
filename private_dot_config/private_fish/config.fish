set fish_greeting ""

# Prompt
set -g fish_prompt_pwd_dir_length 4

# Initialize shortening map for the prompt
source (dirname (status --current-filename))/gc_pwd_shortening_init.fish

# PATH
# TODO: rewrite this using `fish_add_path` (which was added in fish 3.2.0, but Ubuntu 18.04 still has fish 2.7.1)
set -g PATH ~/bin $PATH
