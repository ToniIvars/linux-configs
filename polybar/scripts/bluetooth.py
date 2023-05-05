#!/usr/bin/python3

from subprocess import check_output

def bluetooth_on():
    try:
        output = check_output('bluetoothctl show'.split()).decode('utf-8')
    except:
        return False

    return bool(output.count('Powered: yes'))

def main():
    devices = check_output('bluetoothctl devices'.split()).decode('utf-8').splitlines()

    if not devices:
        return ''

    for device in devices:

        device = device.split()

        mac = device[1]
        output = check_output(f'bluetoothctl info {mac}'.split()).decode('utf-8').splitlines()

        for line in output:
            if 'Connected' in line:
                if line.split()[-1] == 'yes':
                    return '%{F#0082FC}󰂱 '

    return ''

if __name__ == '__main__':
    if bluetooth_on():
        print(main())

    else:
        print('%{F#555}󰂲')
