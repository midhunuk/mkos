#!/bin/bash

# Function to check if rclone is installed
check_rclone_installed() {
    if ! command -v rclone &> /dev/null; then
        echo "rclone is not installed."
        return 1
    else
        echo "rclone is already installed."
        return 0
    fi
}

# Function to install or upgrade rclone
install_or_upgrade_rclone() {
    echo "Installing or upgrading rclone..."
    sudo -v ; curl https://rclone.org/install.sh | sudo bash
    echo "rclone installation or upgrade completed."
}

# Function to configure rclone for Google Drive
setup_rclone_google_drive() {
    echo "Starting rclone configuration for Google Drive..."
    rclone config
}

# Main script logic
if ! check_rclone_installed; then
    install_or_upgrade_rclone
fi

echo "Do you want to configure rclone for Google Drive now? (y/n)"
read -r config_choice
if [[ "$config_choice" == "y" || "$config_choice" == "Y" ]]; then
    setup_rclone_google_drive
else
    echo "You can configure rclone later by running 'rclone config'."
fi
