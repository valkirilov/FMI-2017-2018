#!/bin/bash

declare -A morse_codes_dict
secret_message_morse_encrypted=$""
secret_message_plain_encrypted=$""

read_morse_codes_dict() {
    while read line
    do
        letter=`echo $line | cut -d ' ' -f 1`
        letter="$(tr [A-Z] [a-z] <<< "$letter")"
        code=`echo $line | cut -d ' ' -f 2`
        morse_codes_dict[$code]=$letter
        #echo "$letter - ${morse_codes_dict[$code]}"
    done < morse
}

print_morse_codes_dict() {
    for index in ${!morse_codes_dict[*]}
    do
        echo "$index - ${morse_codes_dict[$index]}"
    done
}

read_secret_message() {
    secret_message_morse_encrypted=$(cat secret_message)
}

convert_morse_to_plain() {
    for i in $(echo $secret_message_morse_encrypted | tr " " "\n")
    do
        secret_message_plain_encrypted+=${morse_codes_dict[$i]}
    done

    #echo $secret_message_plain_encrypted
}

write_plain_secret_message() {
    encrypted_message_file=./encrypted

    echo "$secret_message_plain_encrypted" > "$encrypted_message_file"
}

read_morse_codes_dict
#print_morse_codes_dict

read_secret_message
#echo $secret_message_morse_encrypted

convert_morse_to_plain
write_plain_secret_message