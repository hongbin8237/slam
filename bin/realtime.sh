#!/usr/bin/env sh
# bin/realtime.sh
# Martin Miller
# Created: 2014/07/07
# Simulate real-time
RTOPTS="data/bodyHist3.txt data/altHist.hex data/aHistF.hex data/dt.fifo data/qbwHistF.hex data/wHistF.hex"
FASTOPTS="data/bodyHist3.txt data/altHist.hex data/aHistF.hex \
data/dtHist.txt data/qbwHistF.hex data/wHistF.hex"
#mkfifo data/dt.fifo 2>/dev/null
#mkfifo data/altitude.fifo 2>/dev/null
#mkfifo data/acceleration.fifo 2>/dev/null
#mkfifo data/quaternion.fifo 2>/dev/null
#mkfifo data/angular_velocity.fifo 2>/dev/null
#./bin/sensor-emu data/dtHist.txt >data/dt.fifo &
#./bin/sensor-emu /home/marty/ARC/data/Nov2720131205/alt|stdbuf -oL -eL sed \
#'s/[0-9]*,//'| stdbuf -oL -eL sed 's/,$//' | stdbuf -oL -eL ./bin/multitap \
#data/altitude.fifo &
#
#./bin/sensor-emu /home/marty/ARC/data/Nov2720131205/acc|stdbuf -oL -eL sed \
#'s/[0-9]*,//'| stdbuf -oL -eL ./bin/multitap data/acceleration.fifo &
#
#./bin/sensor-emu /home/marty/ARC/data/Nov2720131205/attitude|stdbuf -oL -eL sed \
#'s/[0-9]*,//'| stdbuf -oL -eL ./bin/multitap data/angular_velocity.fifo &
#
#./bin/sensor-emu /home/marty/ARC/data/Nov2720131205/gyro|stdbuf -oL -eL sed \
#'s/[0-9]*,//'| stdbuf -oL -eL ./bin/euler2qbw | stdbuf -oL -eL ./bin/multitap \
#data/quaternion.fifo &



./bin/slam $FASTOPTS

#DATA=/home/marty/ARC/data/Nov2720131205
DATA=/home/marty/ARC/data/2nd

BODY=data/bodyHist3.txt
DT=data/dt.fifo
ALT=data/alt.fifo
ACC=data/acc.fifo
QBW=data/qbw.fifo
ANGVEL=data/w.fifo

rm -f data/*.fifo
mkfifo $ALT 2>/dev/null
mkfifo $ACC 2>/dev/null
mkfifo $QBW 2>/dev/null
mkfifo $ANGVEL 2>/dev/null
mkfifo $DT 2>/dev/null

./bin/sensor-emu $DATA/alt|stdbuf -oL -eL sed 's/[0-9]*,//'| \
stdbuf -oL -eL sed 's/,$//' | \
stdbuf -oL -eL ./bin/multitap $ALT &

./bin/sensor-emu $DATA/acc|stdbuf -oL -eL sed 's/[0-9]*,//'| \
    stdbuf -oL -eL ./bin/multitap $ACC &

./bin/sensor-emu $DATA/attitude|stdbuf -oL -eL sed 's/[0-9]*,//'| \
    stdbuf -oL -eL ./bin/multitap $ANGVEL &

./bin/sensor-emu $DATA/gyro|stdbuf -oL -eL sed 's/[0-9]*,//'| \
    stdbuf -oL -eL ./bin/euler2qbw | \
    stdbuf -oL -eL ./bin/multitap $QBW &

./bin/sensor-emu data/dtRaw.txt d|stdbuf -oL -eL sed 's/[0-9]*,//' > $DT &

./bin/slam $BODY $ALT $ACC $DT $QBW $ANGVEL || killall -9 multitap
rm -f data/*.fifo

