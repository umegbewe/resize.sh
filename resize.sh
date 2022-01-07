#!/bin/bash

read -p "Size to resize to: " SIZE

EC2_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)

VOLUME_ID=$(aws ec2 describe-instances --output text --instance-id $EC2_INSTANCE_ID \
  --query "Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.VolumeId")
  

aws ec2 modify-volume --volume-id $VOLUME_ID --size ${SIZE}

STATE=$(aws ec2 describe-volumes-modifications --volume-id $VOLUME_ID --output text | awk '{print $3}')

    if [[ "$STATE" == "optimizing" ]]; then
        echo -n "Waiting for resize operation to complete....."
        echo " "
        sleep 5
    fi
    
if [[ $(readlink -f /dev/xvda) = "/dev/xvda" ]]; then
    sudo growpart /dev/xvda 1
    
    STR=$(cat /etc/os-release)
    SUB="VERSION_ID=\"2\""
      
    if [[ "$STR" =~ .*"$SUB".* ]]; then
        sudo xfs_growfs -d /
    else
        sudo resize2fs /dev/xvda1
    fi
    
else
  sudo growpart /dev/nvme0n1 1

  STR=$(cat /etc/os-release)
  SUB="VERSION_ID=\"2\""
  if [[ "$STR" =~ .*"$SUB".* ]]
  then
    sudo xfs_growfs -d /
  else
    sudo resize2fs /dev/nvme0n1p1
  fi
fi
    


## Script termination
exit_on_signal_SIGINT() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Interrupted." 2>&1; reset_color; }
    exit 0
}

exit_on_signal_SIGTERM() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Terminated." 2>&1; reset_color; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM
