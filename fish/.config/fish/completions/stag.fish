# This is heavily inspired by pacman completions

set -l progname stag

function __fish_stag_list_tags
    test -d tags && find tags -mindepth 1 -maxdepth 1 -type d -printf '%P\n' || return 0
end
function __fish_stag_list_files
    test -d all && find all -mindepth 1 -maxdepth 1 -type f -printf '%P\n' || return 0
end
function __fish_stag_list_views
    test -d views && find views -mindepth 1 -maxdepth 1 -type d -printf '%P\n' || return 0
end
set -l list_tags "(__fish_stag_list_tags)"
set -l list_files "(__fish_stag_list_files)"
set -l list_views "(__fish_stag_list_views)"

set -l op__none 'not __fish_contains_opt -s U -s Q -s T -s R -s F -s V -s O'
set -l op_import '__fish_contains_opt -s U'
set -l op_query '__fish_contains_opt -s Q'
set -l op_file_tags '__fish_contains_opt -s T'
set -l op_tag_meta '__fish_contains_opt -s R'
set -l op_fix '__fish_contains_opt -s F'
set -l op_views '__fish_contains_opt -s V'
set -l op_open '__fish_contains_opt -s O'

complete -c $progname -e
complete -c $progname -f

# Primary operations
complete -c $progname -s U -n "$op__none" -d 'Import external files'
complete -c $progname -s Q -n "$op__none" -d 'Query the database'
complete -c $progname -s T -n "$op__none" -d 'Manage file tags'
complete -c $progname -s R -n "$op__none" -d 'Manage tags themselves'
complete -c $progname -s F -n "$op__none" -d 'Fix possible issues'
complete -c $progname -s V -n "$op__none" -d 'Manage views'
complete -c $progname -s O -n "$op__none" -d 'Open tags, views, or files'

# Import operation
complete -c $progname -n "$op_import" -s t -l tags -d 'Tags to be added to all imported files' -f -a $list_tags
complete -c $progname -n "$op_import" -s r -l remove-source -d 'Delete source files after importing'
complete -c $progname -n "$op_import" -s n -l no-remove-source -d "Don't delete source files after importing"
complete -c $progname -n "$op_import" -a -F # files are the positional arguments

# Query operation
set -l op_query_nosub 'not __fish_contains_opt -s t -s s list-tags stats'
complete -c $progname -n "$op_query && $op_query_nosub" -s t -l list-tags -f -d 'List tags'
complete -c $progname -n "$op_query && $op_query_nosub" -s s -l stats -f -d 'Show general statistics'
complete -c $progname -n "$op_query && not __fish_contains_opt -s s stats" -d 'File' -xa $list_files

# File Tags operation
set -l op_file_tags_tag_untag 'not __fish_contains_opt -s t -s u tag untag'
set -l op_file_tags_untag 'not __fish_contains_opt -s u untag'
set -l op_file_tags_renumber_dont 'not __fish_contains_opt -s r -s n renumber no-renumber'
complete -c $progname -n "$op_file_tags && $op_file_tags_tag_untag" -s t -l tag -f -d 'Add tags'
complete -c $progname -n "$op_file_tags && $op_file_tags_tag_untag" -s u -l untag -f -d 'Remove tags'
complete -c $progname -n "$op_file_tags && $op_file_tags_untag && $op_file_tags_renumber_dont" -s r -l renumber -f -d 'Renumber files after untagging'
complete -c $progname -n "$op_file_tags && $op_file_tags_untag && $op_file_tags_renumber_dont" -s n -l no-renumber -f -d "Don't renumber files after untagging"
complete -c $progname -n "$op_file_tags" -d 'File' -xa $list_files
complete -c $progname -n "$op_file_tags" -d 'Tag' -xa $list_tags

# Tag Meta operation
function __fish_stag_tag_meta_identify_op
    set -l op create
    for token in (commandline -opc)
        if test $token = '-c' || test $token = '--create'
            set op create
        else if test $token = '-d' || test $token = '--delete'
            set op delete
        else if test $token = '-m' || test $token = '--rename'
            set op rename
        end
    end
    echo $op
end
function __fish_stag_tag_meta_current_create
    test (__fish_stag_tag_meta_identify_op) = 'create'
end
function __fish_stag_tag_meta_current_delete
    test (__fish_stag_tag_meta_identify_op) = 'delete'
end
function __fish_stag_tag_meta_current_rename
    set -l counter 0
    set -l is_rename 0
    for token in (commandline -opc)
        if test $token = '-c' || test $token = '--create' || test $token = '-d' || test $token = '--delete'
            set is_rename 0
        else if test $token = '-m' || test $token = '--rename'
            set is_rename 1
            set counter 0
        else
            set counter (math $counter + 1)
        end
    end
    if test $is_rename -eq 1 && test $counter -eq $argv[1]
        return 0
    else
        return 1
    end
end
complete -c $progname -n "$op_tag_meta" -s c -l create -f -d 'Create tags'
complete -c $progname -n "$op_tag_meta" -s d -l remove -l delete -f -d 'Remove/delete tags'
complete -c $progname -n "$op_tag_meta" -s m -l rename -f -d 'Rename a tag'
complete -c $progname -n "$op_tag_meta && __fish_stag_tag_meta_current_create" -x
complete -c $progname -n "$op_tag_meta && __fish_stag_tag_meta_current_delete" -d 'Tag' -xa $list_tags
complete -c $progname -n "$op_tag_meta && __fish_stag_tag_meta_current_rename 0" -d 'Tag' -xa $list_tags
complete -c $progname -n "$op_tag_meta && __fish_stag_tag_meta_current_rename 1" -x

# Fix operation
set -l op_fix_nosub "not __fish_contains_opt -s r renumber -s b broken"
complete -c $progname -n "$op_fix && $op_fix_nosub" -s r -l renumber -f -d 'Renumber links in tags'
complete -c $progname -n "$op_fix && $op_fix_nosub" -s b -l broken -f -d 'Fix broken links interactively'
complete -c $progname -n "$op_fix && __fish_contains_opt -s b broken" -s f -l force -d 'Delete all broken links'
complete -c $progname -n "$op_fix && not $op_fix_nosub" -s v -l inverse -d 'Invert the filter'
complete -c $progname -n "$op_fix" -d 'Tag' -xa $list_tags

# Views operation
complete -c $progname -n "$op_views" -s f -l force -f -d 'Always recompute view contents'
complete -c $progname -n "$op_views" -d 'View' -xa $list_views

# Open operation
set -l op_open_clean_noclean 'not __fish_contains_opt -s c clean -s n no-clean'
complete -c $progname -n "$op_open && $op_open_clean_noclean" -s c -l clean -d 'Clean up views automatically'
complete -c $progname -n "$op_open && $op_open_clean_noclean" -s n -l no-clean -d "Don't clean up views automatically"
complete -c $progname -n "$op_open" -d 'Tag' -xa $list_tags
complete -c $progname -n "$op_open" -d 'File' -xa $list_files
complete -c $progname -n "$op_open" -d 'View' -xa $list_views
