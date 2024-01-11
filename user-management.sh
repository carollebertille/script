#!/bin/bash



USERNAME=$1
PASSWORD=$2
EMAIL=$3
FIRSTNAME=$4
LASTNAME=$5
ACCOUNT_MANAGEMENT=$7


echo "Username: ${USERNAME}"
echo "Password : ${PASSWORD}"
echo "Email: ${EMAIL}"
echo "First Name: ${FIRSTNAME}"
echo "Last Name: ${LASTNAME}"
echo "Account managemnet: ${ACCOUNT_MANAGEMENT}"

manage_user_account() {
    if [ "${ACCOUNT_MANAGEMENT}" == "add_user" ]; then
        if ! grep -q "^${USERNAME}:" /etc/passwd; then
            sudo useradd -m "${USERNAME}"
            echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
            sudo usermod -c "${FIRSTNAME} ${LASTNAME}" "${USERNAME}"
            sudo cat /etc/passwd | grep "${USERNAME}"
            sudo cat /etc/shadow | grep "${USERNAME}"
            ls /home
        else
            echo "User ${USERNAME} already exists"
        fi
    elif [ "${ACCOUNT_MANAGEMENT}" == "delete_user" ]; then
        if ! grep -q "^${USERNAME}:" /etc/passwd; then
            echo "User ${USERNAME} does not exist"
        else
            sudo userdel -r "${USERNAME}"
            echo "The user ${USERNAME} with password ${PASSWORD} has been deleted"
            sudo cat /etc/passwd | grep "${USERNAME}" || true
            sudo cat /etc/shadow | grep "${USERNAME}" || true
        fi
    elif [ "${ACCOUNT_MANAGEMENT}" == "lock_user" ]; then
        if ! grep -q "^${USERNAME}:" /etc/passwd; then
            echo "User ${USERNAME} does not exist"
        else
            sudo passwd -l "${USERNAME}"
            echo "The user ${USERNAME} with password ${PASSWORD} has been locked"
            sudo cat /etc/shadow | grep "${USERNAME}"
        fi
    elif [ "${ACCOUNT_MANAGEMENT}" == "unlock_user" ]; then
        if ! grep -q "^${USERNAME}:" /etc/passwd; then
            echo "User ${USERNAME} does not exist"
        else
            sudo passwd -u "${USERNAME}"
            echo "The user ${USERNAME} with password ${PASSWORD} has been unlocked"
            sudo cat /etc/shadow | grep "${USERNAME}"
        fi
    else
        echo "Invalid ACCOUNT_MANAGEMENT action: ${ACCOUNT_MANAGEMENT}"
    fi
}

manage_user_account
