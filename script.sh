#!/run/current-system/sw/bin/bash
FILE="/mnt/llm-models/test.bin"
SIZE="500" # MB

echo "Creating ${SIZE}MB test file..."
dd if=/dev/urandom of=$FILE bs=1M count=$SIZE 2>/dev/null

echo "Dropping caches..."
sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null

echo "First read (cold cache):"
time dd if=$FILE of=/dev/null bs=1M 2>&1 | grep -E "copied|real"

echo "Second read (warm cache):"
time dd if=$FILE of=/dev/null bs=1M 2>&1 | grep -E "copied|real"

echo -e "\nCache stats:"
cat /proc/fs/fscache/stats | grep -E "Lookups|Retrievals|Hits"

