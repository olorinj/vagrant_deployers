#!/bin/bash
if [ ! -f /home/vagrant/.first-run ]
    then
    sudo apk update
    sudo apk add git python3 py3-pip gcc python3-dev libevent-dev musl-dev linux-headers g++
    sudo ln -s /usr/bin/python3 /usr/bin/python
    sudo -- sh -c -e "echo 'export PATH=/home/vagrant/.local/bin:$PATH' >> /etc/profile"
    source /etc/profile
    touch /home/vagrant/.first-run
    git clone https://github.com/StackZeroSec/sdwa.git
    sudo chown -R vagrant:vagrant sdwa/
    cd sdwa
    pip install -r requirements.txt
    rm db/vuln_db.sqlite
    python db/setup_db.py
    l=$(grep -n 'if __' app.py | cut -d':' -f1)
    sed -i "${l}i@app.route('/shutdown')\ndef shutdown():\n    os.system('sudo poweroff')\n    return '<h2>Server shutting down...</h2>'\n" app.py
fi
cd /home/vagrant/sdwa
flask run --host=0.0.0.0
