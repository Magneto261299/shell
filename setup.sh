if [[ -n $RCLONE_CONFIG_BASE64 ]]; then
	echo "Rclone config detected"
    mkdir -p /usr/src/app/.config/rclone
	echo "$(echo $RCLONE_CONFIG_BASE64|base64 -d)" >> /usr/src/app/.config/rclone/rclone.conf
fi

if [[ -n $BOT_TOKEN && -n $OWNER_ID ]]; then
	echo "Bot token and owner ID detected"
	python3 config.py
fi

if [[ -n $CREDENTIALS_LINK ]]; then
	echo "credentials.jso detected"
    aria2c $CREDENTIALS_LINK && drivedl set /usr/src/app/credentials.json
fi

if [[ -n $TOKEN_PICKLE_URL ]]; then
	echo "credentials.jso detected"
    aria2c $TOKEN_PICKLE_URL
fi

if [[ -n $ACCOUNTS_FOLDER_LINK ]]; then
	echo "credentials.jso detected"
    aria2c $ACCOUNTS_FOLDER_LINK
fi

echo "SETUP COMPLETED"
