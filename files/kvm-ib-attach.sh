#!/bin/bash

host=$1
bus=$2
slot=$3
function=$4

# check if given vm is running here, only check pcie if yes
if virsh list --name|egrep -q ^${host}; then

# check if pci dev already attached, if not, then add
  if virsh dumpxml $host | grep -q "bus='$bus' slot='$slot' function='$function'"; then
    echo "host: $host pcie dev ok"
  else

(
cat <<EOF >/tmp/$host.dev.xml
<hostdev mode='subsystem' type='pci' managed='yes'>
 <source>
 <address type='pci' domain='0x0000' bus='$bus' slot='$slot' function='$function'/>
 </source>
</hostdev>
EOF
)

  virsh attach-device $host /tmp/$host.dev.xml --live --config

  fi
else
  echo "no $host found running on this host"
fi
