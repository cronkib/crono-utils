#!/bin/bash
#
# GPG-Reduce
#
command=$1

function help {
    echo "Usage: gpgr <command> <options>"
    echo "Supported Commands: "
    echo -e "    encrypt      <receiver> <filename>  -- Encrypt file to send"
    echo -e "    decrypt      <filename>             -- Decrypt file from trusted sender"
    echo -e "    import       <filename>             -- Import a trusted user's public key"
    echo -e "    export       <name>                 -- Export public key of user"
    echo -e "    fingerprint  <name>                 -- Show fingerprint for user"
}

gpg_encrypt_help() {
    echo "Usage: gpgr encrypt <receiver> <filename>"
}
gpg_encrypt() {
    receiver=$1
    filename=$2

    if [ -z "$receiver" ]; then
        echo "Missing receiver"
        gpg_encrypt_help
        exit 1
    elif [ -z "$filename" ]; then
        echo "Missing filename"
        gpg_encrypt_help
        exit 1
    fi

    run="gpg -e -r \"$receiver\" $filename"
    echo $run
    eval $run
}

gpg_decrypt_help() {
    echo "Usage: gpgr decrypt <filename>"
}
gpg_decrypt() {
    filename=$1

    if [ -z "$filename" ]; then
        echo "Missing filename"
        gpg_decrypt_help
        exit 1
    fi

    run="gpg -d $filename"
    echo $run
    eval $run
}

gpg_list() {
    run="gpg --list-keys"
    eval $run
}

gpg_import_help() {
    echo "Usage: gpgr import <filename>"
}
gpg_import() {
    filename=$1

    if [ -z "$filename" ]; then
        echo "Missing filename"
        gpg_import_help
        exit 1
    fi

    run="gpg --import $filename"
    echo $run
    eval $run
}

gpg_export_help() {
    echo "Usage: gpgr export <name> <filename>"
}
gpg_export() {
    name=$1
    filename=$2

    if [ -z "$name" ]; then
        echo "Missing name"
        gpg_export_help
        exit 1
    fi

    if [ -z "$filename" ]; then
        run="gpg --export -a \"$name\""
    else
        run="gpg --export -a \"$name\" > $filename"
    fi

    echo $run
    eval $run
}

gpg_fingerprint_help() {
    echo "Usage: gpgr fingerprint <name>"
}
gpg_fingerprint() {
    name=$1

    if [ -z "$name" ]; then
        echo "Missing name"
        gpg_fingerprint_help
        exit 1
    fi

    run="gpg --fingerprint \"$name\""
    echo $run
    eval $run
}

if [ -z "$command" ]; then
    echo "Missing command"
    help
elif [[ "$command" == "help" ]]; then
    help
elif [[ "$command" == "encrypt" ]]; then
    gpg_encrypt "$2" "$3"
elif [[ "$command" == "decrypt" ]]; then
    gpg_decrypt "$2"
elif [[ "$command" == "import" ]]; then
    gpg_import "$2"
elif [[ "$command" == "export" ]]; then
    gpg_export "$2" "$3"
elif [[ "$command" == "fingerprint" ]]; then
    gpg_fingerprint "$2"
elif [[ "$command" == "list" ]]; then
    gpg_list
else
    echo "Invalid command"
    help
fi
