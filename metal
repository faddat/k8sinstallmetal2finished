From the top:
get the igor pekovnik banana pi image:

 http://www.armbian.com/banana-pi/

unzip the zip and then dd the .img file to a sd card


install gym moovweb/gvm:

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)




gym install go1.4
gym use go1.4
gym install go1.5
gym use go1.5
git clone https://github.com/danderson/pixiecore
cd pixiecore
go get .
go build .
mv pixiecore /usr/bin

Get the files for CoreOS:
wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz
wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz
pixiecore -kernel coreos_production_pxe.vmlinuz -initrd coreos_production_pxe_image.cpio.gz --cmdline coreos.autologin
