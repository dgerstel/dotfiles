# TBrowser
tbrowser () {
  # Check a file has been specified
  if (( $# == 0 )); then
    echo "No file(s) specified."
  else
    # For each file, check it exists
    for i; do
      if [ ! -f $i ]; then
        echo "Could not find file $i"
        return 1;
      fi
    done
    root -l $* $HOME/.macros/newBrowser.C
  fi
}

# grep ntuple branches
tgrep () {
    if [ $# -ne 2 ] && [ $# -ne 3 ] && [ $# -ne 4 ]; then
        echo "Usage: $ tgrep -k=<keyword> -t=<path/to/tuple> -d=<tree_directory> [-a=<grep_argument>]"
        return 1;
    fi
    # Extract the grep command (with /out options)
    # if [ $# -eq 2 ]; then
    #     grep_cmd="grep"
    #     grep_regexp=$1
    # elif [ $# -ge 3 ]; then
    #     grep_cmd="grep $1"
    #     grep_regexp=$2
    # fi
    # tree_path="DecayTree"
    # if [ $# -eq 4 ]; then
    #     tree_path=$4
    # fi
    # Get the tuple and its directory in the root file
    for i in "$@"
    do
        case $i in
            -k=*|--keyword=*)
                KEYWORD="${i#*=}"
                ;;
            -t=*|--tuple=*)
                TUPLE="${i#*=}"
                ;;
            -d=*|--tupledir=*)
                TUPLEDIR="${i#*=}"
                ;;
            -a=*|--greparg=*)
                GREP_ARG="${i#*=}"
                ;;
            *)
                #unknown option
                ;;
        esac
    done
    echo TUPLE = ${TUPLE}
    echo TUPLEDIR = ${TUPLEDIR}
    echo KEYWORD = ${KEYWORD}
    # Use grep
    echo 't=(TTree*)'"${TUPLEDIR}"'->Get("DecayTree"); t->Show()'
#    echo 't=(TTree*)Bd2DsttaunuTuple->Get("DecayTree"); t->Show()' | root -l $TUPLE
#    echo 't=(TTree*)'"${TUPLEDIR}"'->Get("DecayTree"); t->Show()' | root -l $TUPLE | tee >(wc -l) >(echo) | grep $KEYWORD $GREP_ARG
    echo 't=(TTree*)'"${TUPLEDIR}"'->Get("DecayTree"); t->Show()' | root -l $TUPLE | grep $KEYWORD $GREP_ARG
}


alias tb="tbrowser"
alias root="root -l"
