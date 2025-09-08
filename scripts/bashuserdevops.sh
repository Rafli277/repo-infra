# Buat user devops (jika belum ada)
sudo useradd -m -s /bin/bash devops

# Set password (opsional)
sudo passwd devops

# Tambahkan ke sudo group
sudo usermod -aG sudo devops

sudo usermod -aG docker devops

# Buat user devops
useradd -m -s /bin/bash devops

# Tambahkan ke sudo & docker group
usermod -aG sudo,docker devops
