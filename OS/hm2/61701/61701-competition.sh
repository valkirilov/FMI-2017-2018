#!/bin/bash

destination_directory=$""
command=$""
valid_input=true

names_list=()

read_input() {
    if [ -z "$1" ]; then
        valid_input=false
        echo "No argument supplied for destination directory"
    else
        destination_directory="$1"
    fi

    if [ ! -d "$1" ]; then
        valid_input=false
        echo "Please provide a valid directory name as a first argument"
    fi

    if [ -z "$2" ]; then
        valid_input=false
        echo "No argument supplied for command function"
    elif [ "$2" != "participants" ] &&
        [ "$2" != "outliers" ] &&
        [ "$2" != "unique" ] &&
        [ "$2" != "cross_check" ] &&
        [ "$2" != "bonus" ];
        then
        valid_input=false
        echo "Please provide a valid function name as a second argument"
    else
        command="$2"
    fi

    #echo $destination_directory
    #echo $command
}

participants() {
    for file in $destination_directory/*; do
        name=$(basename $file)
        names_list+=($name)

        # Print output if called from root
        if [ "$1" = true ]; then
            echo $name
        fi
    done
}

outliers() {
    participants false
    outliers_list=()

    # Loop through all of the names and read every log
    for i in "${names_list[@]}"
    do
        participant_log_file="$destination_directory/$i"

        while read -r line
        do
            if [[ $line == QSO:* ]]; then
                recipient=`echo $line | cut -d ' ' -f 9`

                # If the recipient is not marked as an outlier do it
                if [[ ! " ${outliers_list[@]} " =~ " ${recipient} " ]]; then
                    outliers_list+=($recipient)
                fi
            fi
        done < "$participant_log_file"
    done

    # Print the list with the outliers
    for i in "${outliers_list[@]}"
    do
        echo $i
    done
}

unique() {
    participants false
    declare -A names_occurances_dict

    # Loop through all of the names and read every log
    for i in "${names_list[@]}"
    do
        participant_log_file="$destination_directory/$i"

        while read -r line
        do
            if [[ $line == QSO:* ]]; then
                recipient=`echo $line | cut -d ' ' -f 9`
                # Check if the recipient is a valid competitor
                if [[ " ${names_list[@]} " =~ " ${recipient} " ]]; then
                    # Count the occurances of that competitor
                    if [ ${names_occurances_dict[$recipient]+abc} ]; then
                        ((names_occurances_dict[$recipient]++))
                    else
                        names_occurances_dict[$recipient]=1
                    fi
                fi
            fi
        done < "$participant_log_file"
    done

    # Print the list with the uniqe occurancies
    for i in "${!names_occurances_dict[@]}"
    do

        if [ "${names_occurances_dict[$i]}" -le 3 ]; then
            echo $i
            #echo "value: ${names_occurances_dict[$i]}"
        fi
    done
}

cross_check() {
    participants false

    # Loop through all of the names and read every log
    for i in "${names_list[@]}"
    do
        participant_log_file="$destination_directory/$i"

        while read -r line
        do
            if [[ $line == QSO:* ]]; then
                recipient=`echo $line | cut -d ' ' -f 9`
                date_log1=`echo $line | cut -d ' ' -f 4`
                time_log1=`echo $line | cut -d ' ' -f 5`

                recipient_log_file="$destination_directory/$recipient"
                recipient_is_cross_check_found=false

                # Loop though the recipient logs if available
                if [ -f $recipient_log_file ]; then
                    while read -r recipient_line
                    do
                        if [[ $recipient_line == QSO:* ]]; then
                            sender=`echo $line | cut -d ' ' -f 9`
                            date_log2=`echo $line | cut -d ' ' -f 4`
                            time_log2=`echo $line | cut -d ' ' -f 5`

                            # Check if the log exists in the current file
                            if [ "$i" = "$sender" ] &&
                                [ "$date_log1" = "$date_log2" ] &&
                                [ "$time_log1" = "$time_log2" ];
                            then
                                recipient_is_cross_check_found=true
                            fi

                        fi
                    done < "$recipient_log_file"
                fi

                # If there is not avaiable info for a cross check print the current log line
                if [ "$recipient_is_cross_check_found" = false ]; then
                    echo $line
                fi

            fi
        done < "$participant_log_file"
    done
}

bonus() {
    echo "TODO: bonus"
}

read_input $1 $2

if [ "$valid_input" = true ]; then
    $command true
fi