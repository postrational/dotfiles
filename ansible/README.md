```shell

# Clone the repository
cd /tmp
git clone https://github.com/postrational/dotfiles.git
cd dotfiles/ansible

# Unlock a Bitwarden session
export BW_SESSION=$(bw unlock --raw)

# Install ansible in a virtual environment
python3 -m venv .venv
source .venv/bin/activate
pip install ansible

# Run one of the playbooks
ansible-playbook macos.yaml
ansible-playbook ubuntu.yaml

# For Arch Linux, you need to install the AUR helper <eye roll>
ansible-galaxy collection install kewlfft.aur
ansible-playbook archlinux.yaml
```