# Oracle VM → Ubuntu generic kernel → Judge0
1. Check which kernel you're currently running
uname -r

If you see something like:

6.17.0-1020-oracle

you're running the Oracle kernel.

Also check whether the required cgroup v1 options exist:

grep -E 'CONFIG_MEMCG_V1|CONFIG_CPUSETS_V1' /boot/config-$(uname -r)

Problematic Oracle kernel:

# CONFIG_MEMCG_V1 is not set
# CONFIG_CPUSETS_V1 is not set

What we need:

CONFIG_MEMCG_V1=y
CONFIG_CPUSETS_V1=y
2. Install an Ubuntu generic kernel

First update package information:

sudo apt update

Then install the generic kernel:

sudo apt install linux-image-generic

You can see available generic kernels with:

apt search linux-image-*-generic

On your VM, this resulted in:

6.17.0-42-generic

After installation, verify that the new kernel has the required configuration:

grep -E 'CONFIG_MEMCG_V1|CONFIG_CPUSETS_V1' /boot/config-6.17.0-42-generic

Expected:

CONFIG_MEMCG_V1=y
CONFIG_CPUSETS_V1=y

Use whatever version was actually installed rather than assuming 6.17.0-42.

3. Check the GRUB entries
grep -E "^menuentry |^submenu " /boot/grub/grub.cfg

You'll probably see something similar to:

Ubuntu, with Linux 6.17.0-1020-oracle
Ubuntu, with Linux 6.17.0-1018-oracle
Ubuntu, with Linux 6.17.0-42-generic

The generic kernel may be inside the Advanced options for Ubuntu submenu.

4. Boot the generic kernel once first

Because you're working on a remote VM, test it with a one-time boot before making it permanent.

Find the exact GRUB submenu path:

grep -E "submenu|6.17.0-42-generic" /boot/grub/grub.cfg

Then use:

sudo grub-reboot 'gnulinux-advanced-<UUID> > gnulinux-<generic-kernel-entry>'

On your VM the actual command was:

sudo grub-reboot 'gnulinux-advanced-c3cdec3e-c7b4-4cd9-8bc8-3ceebc53846b>gnulinux-6.17.0-42-generic-advanced-c3cdec3e-c7b4-4cd9-8bc8-3ceebc53846b'

Do not copy the UUID from this example blindly. Get the appropriate identifiers from the new VM's /boot/grub/grub.cfg.

Then:

sudo reboot
5. Verify after reboot
uname -r

You want:

6.17.0-42-generic

Then verify the cgroup configuration:

grep -E 'CONFIG_MEMCG_V1|CONFIG_CPUSETS_V1' /boot/config-$(uname -r)

Expected:

CONFIG_MEMCG_V1=y
CONFIG_CPUSETS_V1=y

You can also check Docker:

docker info | grep -i "Cgroup"

And:

cat /proc/cgroups

The important part is that memory and cpuset are available.

6. Verify Isolate

For Judge0, this is the important test.

Enter the worker container:

docker exec -it judge0-v1131-workers-1 bash

Then:

isolate --cg --init

Previously, with the Oracle kernel, this failed with:

Failed to create control group /sys/fs/cgroup/memory/box-0/

With the generic kernel, it should succeed.

You can also run:

isolate-check-environment

The important cgroup checks should no longer report the missing memory/cpuset controllers.

7. Test Judge0

From the VM:

curl -X POST 'http://localhost:2358/submissions?wait=true' \
  -H 'Content-Type: application/json' \
  -d '{
    "language_id": 71,
    "source_code": "print(\"hello from my Judge0\")"
  }'

You should get something like:

{
  "stdout": "hello from my Judge0\n",
  "time": "0.035",
  "memory": 9360,
  "stderr": null,
  "compile_output": null,
  "message": null,
  "status": {
    "id": 3,
    "description": "Accepted"
  }
}

The crucial result is:

status.id = 3
status.description = Accepted
8. Make the generic kernel permanent

The one-time grub-reboot is mainly for testing.

If you want the VM to always boot the generic kernel, configure GRUB permanently.

First inspect:

grep GRUB_DEFAULT /etc/default/grub

Your VM currently had:

GRUB_DEFAULT=0

That means normal boots select the first entry, which was the Oracle kernel.

You can set the generic kernel as the default using its full GRUB entry path, then:

sudo update-grub

Keep the Oracle kernel installed. That gives you a fallback kernel if the generic one ever causes a problem.

Short version for future VMs

Once you've done this once or twice, the checklist is essentially:

# 1. Check current kernel
uname -r

# 2. Check whether required cgroup v1 support exists
grep -E 'CONFIG_MEMCG_V1|CONFIG_CPUSETS_V1' /boot/config-$(uname -r)

# 3. Install Ubuntu generic kernel
sudo apt update
sudo apt install linux-image-generic

# 4. Find installed generic kernel
ls /boot/vmlinuz-*generic

# 5. Check its config
grep -E 'CONFIG_MEMCG_V1|CONFIG_CPUSETS_V1' /boot/config-*-generic

# 6. Configure a one-time GRUB boot to the generic kernel
sudo grub-reboot '...generic kernel GRUB path...'

# 7. Reboot
sudo reboot

# 8. Verify
uname -r

# 9. Verify cgroup support
grep -E 'CONFIG_MEMCG_V1|CONFIG_CPUSETS_V1' /boot/config-$(uname -r)

# 10. Test Judge0/Isolate
docker exec -it judge0-v1131-workers-1 bash
isolate --cg --init

# 11. Test Judge0 API
curl ... /submissions?wait=true
Why this happens

The important distinction to remember is:

Ubuntu 24.04 ≠ a particular Ubuntu kernel.

An Oracle Cloud Ubuntu image gives you Ubuntu userspace plus Oracle's kernel:

Ubuntu 24.04
├── userspace
├── apt
├── systemd
├── libraries
└── Oracle Linux kernel       ← problem for Judge0

Your local Ubuntu installation uses:

Ubuntu 24.04
├── userspace
├── apt
├── systemd
├── libraries
└── Ubuntu generic kernel     ← works with Judge0

So on a future Oracle VM, don't reinstall Ubuntu just because you see -oracle in uname -r. Install the Ubuntu generic kernel alongside it, test-boot it, verify CONFIG_MEMCG_V1=y and CONFIG_CPUSETS_V1=y, then make it the permanent GRUB default if Judge0 will be running there.


1. Edit /etc/default/grub
sudo nano /etc/default/grub

Find:

GRUB_DEFAULT=0

and replace it with:

GRUB_DEFAULT="gnulinux-advanced-c3cdec3e-c7b4-4cd9-8bc8-3ceebc53846b>gnulinux-6.17.0-42-generic-advanced-c3cdec3e-c7b4-4cd9-8bc8-3ceebc53846b"

So you're telling GRUB:

Inside the Advanced options for Ubuntu submenu, permanently select 6.17.0-42-generic.

2. Regenerate GRUB configuration
sudo update-grub

You should see it detect your kernels, including:

Found linux image: /boot/vmlinuz-6.17.0-42-generic
Found linux image: /boot/vmlinuz-6.17.0-1020-oracle
...
3. Reboot
sudo reboot

After reconnecting:

uname -r

You should get:

6.17.0-42-generic