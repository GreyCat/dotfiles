# Based on sources from fish
# https://github.com/fish-shell/fish-shell/blob/master/share/functions/prompt_pwd.fish
#
# fish Copyright © 2005-2009 Axel Liljencrantz, 2009-2024 fish-shell contributors. fish is released under the GNU General Public License, version 2.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

function prompt_pwd --description 'short CWD for the prompt'
    set -l options h/help d/dir-length= D/full-length-dirs=
    argparse -n prompt_pwd $options -- $argv
    or return

    if set -q _flag_help
        __fish_print_help prompt_pwd
        return 0
    end

    set -q argv[1]
    or set argv $PWD

    set -ql _flag_d
    and set -l fish_prompt_pwd_dir_length $_flag_d

    set -q fish_prompt_pwd_dir_length
    or set -l fish_prompt_pwd_dir_length 1

    set -l fulldirs 0
    set -ql _flag_D
    and set -l fish_prompt_pwd_full_dirs $_flag_D

    set -q fish_prompt_pwd_full_dirs
    or set -l fish_prompt_pwd_full_dirs 1

    for path in $argv
        # Replace $HOME with "~"
        set -l realhome (string escape --style=regex -- ~)
        set -l tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $path)

        # GreyCat: replace path prefixes from `gc_pwd_longs` with `gc_pwd_shorts`
        for i in (seq (count $gc_pwd_longs))
            set tmp (string replace -r '^'"$gc_pwd_longs[$i]"'($|/)' "$gc_pwd_shorts[$i]"'$1' -- $tmp)
        end

        if test "$fish_prompt_pwd_dir_length" -eq 0
            echo $tmp
        else
            # Shorten to at most $fish_prompt_pwd_dir_length characters per directory
            # with full-length-dirs components left at full length.
            set -l full
            if test $fish_prompt_pwd_full_dirs -gt 0
                set -l all (string split -m (math $fish_prompt_pwd_full_dirs - 1) -r / $tmp)
                set tmp $all[1]
                set full $all[2..]
            else if test $fish_prompt_pwd_full_dirs -eq 0
                # 0 means not even the last component is kept
                string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*' '$1' $tmp
                continue
            end

            string join / -- (string replace -ar -- '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' $tmp) $full
        end
    end
end
