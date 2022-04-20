sudo cp /etc/pulse/default.pa /etc/pulse/default.pa.bak
sudo cat <<EOF >> /etc/pulse/default.pa
load-module module-echo-cancel aec_method=webrtc aec_args="analog_gain_control=0 digital_gain_control=1"  source_name=noechosource sink_name=noechosink
set-default-source noechosource
set-default-sink noechosink
EOF