# Bare Metal Install Using PXE boot server served by Banana Pi

## Tasks:
#### 1. Ready your Pi (most likely you can do this with Banana, Orange, and Raspberry Pi's)

 * get the [igor pekovnik banana pi image](http://www.armbian.com/banana-pi/)
 * unzip the zip and then dd the .img file to a sd card

#### 2. Install go and set up Pixiecore
```
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
```
##### Get the files for CoreOS:

```
wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz
wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz
```

#### 3. Make a cloud-config.yml file (this is incomplete and we're going to need to revisit it)

#### Cloud-config.yml (this is incomplete and we're going to need to revisit it)
```
#cloud-config
# include one or more SSH public keys
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDC05g41pQqLINH6rqzOXj37mMH4oi1RvLTB5JW4ZxyTuC0AIPGk79vZq/OZ2JC0Vf7ESMf1zpIST8lDbb9cYbHjhXNUkGlzyqQp99B5s6B9SLkla0t5UYONqg/4LIiiqbPh4SUNG5YXc7sEd1eM6dlSO2Dsj0AyTtrNdCxYVcQDMufCPayzfK0z+7Zan0/zSfJK1Zd21kVvuYRJ/yq3Cb4paN9451EUkrVpbiXEipsSah6jOGNh8EfMNdI6trhzlDVTA3Eq7o8++VFWsemg0Kxj6WLdTc8zS2oyuG/Keiz/mQ6ZpuaX7kIm7bzyFoFuSTsYAWRGI/CWQkJTq/6GiURobdFGfT55A18UkjpxZmWhSs+Px9fRtJEEDKj0i+wImmzUGffUl+Fu89WGrzPuHUbGrdnkWxgfdEhn7eTuczVmSV4iCptNPFMBICHsiApEqtcWTnNhr71CpKwp86dSgokYiHMXlYLM+NUIxPPveh2VZiMYbIigu2lJg1HGwe7NZjt/PRrnEFv4PZ7XA2mtLqR3caluONfNK7y3DzsRk3+SCTZvG6/Yo3OJCCxB8iy/hGJ6eT5Es5voa0+8Z+eWna6DzHsZei3uxGQPl+BT+WTNccOKULsbW6Q/Vr9LlwD+Qst+P6GZzTLYp1qdcaBwmUAOyPwSyQYLXBn65wTf8JocQ==
coreos:
  etcd2:
    # generate a new token for each unique cluster from https://discovery.etcd.io/new?size=3
    # specify the initial size of your cluster with ?size=X
    discovery: https://discovery.etcd.io/11e1b1de9cc795e919b11b130ada083a
    advertise-client-urls: http://0.0.0.0:2379,http://0.0.0.0:4001
    initial-advertise-peer-urls: http://0.0.0.0:2380
    # listen on both the official ports and the legacy ports
    # legacy ports can be omitted if your application doesn't depend on them
    listen-client-urls: http://0.0.0.0:2379,http://0.0.0.0:4001
    listen-peer-urls: http://0.0.0.0:2380
  units:
    - name: etcd2.service
      command: start
    - name: fleet.service
      command: start
    - name: flanneld.service
      command: start
      drop-ins:
      - name: 50-network-config.conf
        content: |
          [Service]
          ExecStartPre=/usr/bin/etcdctl set /coreos.com/network/config '{"Network":"10.1.0.0/16", "Backend": {"Type": "vxlan"}}'
```

#### 4. Provision 5 nodes using pixiecore

* here's the pxe boot command that you can use to boot ALL of the nodes, since right now, the master is no different from a worker.

```
pixiecore -kernel coreos_production_pxe.vmlinuz -initrd coreos_production_pxe_image.cpio.gz --cmdline "coreos.autologin coreos-install -d /dev/sda -C stable"
```

#### 5. Test your setup using fabric8



#### 6. Next steps