function convert_windows_path_to_linux
    set win_path $argv[1]
    echo -E "$win_path" | tr "\\\\" / | sed 's,^\([A-Za-z]\):,/\L\1,'
end

function wincd
    set lin_path (convert_windows_path_to_linux $argv[1])
    # echo -E "Asked to move to \"$argv[1]\""
    # echo -E "Moving to \"$lin_path\""
    cd $lin_path
end
