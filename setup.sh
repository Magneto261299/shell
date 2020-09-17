if [[ -n $RCLONE_CONFIG_BASE64 ]]; then
	echo "Rclone config detected"
    mkdir -p /usr/src/app/.config/rclone
	echo "$(echo $RCLONE_CONFIG_BASE64|base64 -d)" >> /usr/src/app/.config/rclone/rclone.conf
fi

if [[ -n $BOT_TOKEN && -n $OWNER_ID ]]; then
	echo "Bot token and owner ID detected"
	python3 config.py
fi

if [[ -n $CREDENTIALS_URL ]]; then
	echo "credentials.jso detected"
    aria2c $CREDENTIALS_URL
fi

if [[ -n $TOKEN_PICKLE_URL ]]; then
	echo "credentials.jso detected"
    aria2c $TOKEN_PICKLE_URL
fi

if [[ -n $ACCOUNTS_URL ]]; then
	echo "credentials.jso detected"
    aria2c $ACCOUNTS_URL
fi

echo "SETUP COMPLETED"
