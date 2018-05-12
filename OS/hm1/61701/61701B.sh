#!/bin/bash

secret_message_plain_encrypted=$""

declare -A key_offsets
key_offsets["a"]="a-z a-z"
key_offsets["b"]="a-z b-za"
key_offsets["c"]="a-z c-za-b"
key_offsets["d"]="a-z d-za-c"
key_offsets["e"]="a-z e-za-d"
key_offsets["f"]="a-z f-za-e"
key_offsets["g"]="a-z g-za-f"
key_offsets["h"]="a-z h-za-g"
key_offsets["i"]="a-z i-za-h"
key_offsets["j"]="a-z j-za-i"
key_offsets["k"]="a-z k-za-j"
key_offsets["l"]="a-z l-za-k"
key_offsets["m"]="a-z m-za-l"
key_offsets["n"]="a-z n-za-m"
key_offsets["o"]="a-z o-za-n"
key_offsets["p"]="a-z p-za-o"
key_offsets["q"]="a-z q-za-p"
key_offsets["r"]="a-z r-za-q"
key_offsets["s"]="a-z s-za-r"
key_offsets["t"]="a-z t-za-s"
key_offsets["u"]="a-z u-za-t"
key_offsets["v"]="a-z v-za-u"
key_offsets["w"]="a-z w-za-v"
key_offsets["x"]="a-z x-za-w"
key_offsets["y"]="a-z y-za-x"
key_offsets["z"]="a-z z-za-y"

read_secret_message() {
    secret_message_plain_encrypted=$(cat encrypted)
}

decrypt_message() {
    local result=$2
    encrypted_message=$secret_message_plain_encrypted
    decrypted_message=$""
    #echo $1
    #echo ${key_offsets[$1]}

    for (( i=0; i<${#encrypted_message}; i++ )); do
        letter="${encrypted_message:$i:1}"
        decrypted_letter=($(echo ${letter[@]} | tr ${key_offsets[$1]}))
        decrypted_message+=$decrypted_letter

        #echo "$letter -> $decrypted_letter"
    done

    #echo $decrypted_message
    eval $result=$decrypted_message
}

check_message() {
    if [[ $message = *"fuehrer"* ]]; then
        echo "$message"
    fi
}

find_encryption_key() {
    for letter in {a..z} ; do
        decrypt_message "$letter" message
        check_message "$message"
    done
}

read_secret_message
#echo $secret_message_plain_encrypted

find_encryption_key