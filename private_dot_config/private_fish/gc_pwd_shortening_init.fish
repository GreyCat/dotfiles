# Scan all the symlinks in `/` and add it to shortening map

set -g gc_pwd_shorts
set -g gc_pwd_longs

# Traverses in reverse order to work around issue with conflicting symlinks, e.g:
#
# /c => /mnt/c
# /w => /mnt/c/work
#
# If applied in direct order, this will result in `/mnt/c/work/foo` to be
# shortened as `/c/work/foo`, while we want even shorter alternative
# `/w/foo`.

set -l root_entries /*
for file in $root_entries[-1..1]
    if test -L "$file"
        set -l target (readlink "$file")

        set gc_pwd_shorts $gc_pwd_shorts "$file"
        set gc_pwd_longs $gc_pwd_longs "$target"
    end
end
