#!/bin/bash

FNAME="Archivos_$(date +'%d-%m-%Y').zip"
mkdir /tmp/msi_backup

notify-send -a 'MSI Backup' 'Info' 'Compressing "Archivos" in a ZIP file...'
zip -r "/tmp/msi_backup/$FNAME" /home/toni/Archivos -x '*env/*' -x '*venv/*' -x '*node_modules*' -x '*dist/*' -x '*buildozer/*' -x '*__pycache__*' -x '*.cia' -x '*.3ds'

thunar /tmp/msi_backup & disown
