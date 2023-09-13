## Need to be run as root!!
readonly BOOTLOADER_PATH=./u-boot/u-boot-sunxi-with-spl.bin 
# SD Card via MMC (micro sd)
export card=/dev/mmcblk0
export p=p
# Cleaning
# dd if=/dev/zero of=${card} bs=1M count=1
# Bootloader
dd if=$BOOTLOADER_PATH of=${card} bs=1024 seek=8
# Separate boot partition
# blockdev --rereadpt ${card}
# cat <<EOT | sfdisk ${card}
# 1M,16M,c
# ,,L
# EOT
# Other partitions
# mkfs.vfat ${card}${p}1
# mkfs.ext4 ${card}${p}2
# cardroot=${card}${p}2

# Ref: https://linux-sunxi.org/Bootable_SD_card#Bootloader