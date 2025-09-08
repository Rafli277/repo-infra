#!/bin/bash

# Jumlah image yang ingin disimpan
KEEP=1
IMAGE_NAME="rafli27/react-frontend"

# Ambil IMAGE ID dari semua image, urut dari terbaru ke terlama
IMAGES=$(docker images --format "{{.ID}}" $IMAGE_NAME | tail -n +$((KEEP+1)))

# Hapus image yang lebih lama
if [ -n "$IMAGES" ]; then
  echo "Menghapus image lama:"
  echo "$IMAGES"
  docker rmi -f $IMAGES
else
  echo "Tidak ada image lama untuk dihapus."
fi
