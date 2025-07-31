# Some basic stuff I will be needing

## Audio plugin

- sudo apt install calf-plugins

- `ripgrep` to ignore dotfiles/gitignore files from being searched in fzf

---

## for presentation

- github.com/maaslalani/slides

# virtManager

```
#!/bin/bash

# Show usage/help (man-style)
install_kvm_help() {
  cat <<EOF
install_kvm - Install and configure KVM virtualization on Linux Mint/Ubuntu

Usage:
  install_kvm            Check CPU virtualization, install KVM/libvirt/virt-manager,
                        add user to necessary groups, and show status.

No arguments needed.

Steps performed:
  1. Check CPU for virtualization support (vmx or svm flags)
  2. Update apt repositories
  3. Install qemu-kvm, libvirt, bridge-utils, virt-manager
  4. Add current user to libvirt and kvm groups
  5. Show libvirtd service status
  6. List all virtual machines

Note:
  You may need to logout/login or reboot for group changes to take effect.
EOF
}

install_kvm() {
  echo "Checking CPU virtualization support..."
  if egrep -q '(vmx|svm)' /proc/cpuinfo; then
    echo "Virtualization supported!"
  else
    echo "ERROR: Virtualization not supported on this CPU."
    return 1
  fi

  echo "Updating package lists..."
  sudo apt update || { echo "Failed to update packages"; return 1; }

  echo "Installing KVM and related packages..."
  sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager || { echo "Failed to install packages"; return 1; }

  echo "Adding user $USER to libvirt and kvm groups..."
  sudo usermod -aG libvirt "$USER"
  sudo usermod -aG kvm "$USER"

  echo "Checking libvirtd service status..."
  sudo systemctl status libvirtd --no-pager

  echo "Listing all virtual machines..."
  virsh list --all

  echo ""
  echo "Setup complete! Please logout/login or reboot to apply group changes."
}
```

## insomnia

```
wget "https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app" -O insomnia.deb
sudo dpkg -i insomnia.deb
sudo apt-get install -f
```
