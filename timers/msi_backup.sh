#!/bin/bash

FNAME="Archivos_$(date +'%d-%m-%Y').zip"

notify-send -a 'MSI Backup' 'Info' 'Compressing "Archivos" in a ZIP file...'
zip -r "/tmp/$FNAME" ~/Archivos -x '*env/*' -x '*venv/*' -x '*node_modules*' -x '*dist/*' -x '*buildozer/*'

notify-send -a 'MSI Backup' 'Info' 'Uploading compressed file...'
source "/home/toni/Archivos/msi_backup/env/bin/activate"
python ~/Archivos/msi_backup/drive_upload.py 'MSI BACKUP' "/tmp/$FNAME"

if [ $? -eq 0 ]; then
    notify-send -a 'MSI Backup' 'Info' "Backed up file <b>$FNAME</b>"
else
    notify-send -u critical -a 'MSI Backup' 'Error' "There was an error backuping the file <b>$FNAME</b>"
fi