#!/bin/bash
## seed.iso生成
cd SeedIsoConfig
genisoimage -output seed.iso -volid cidata -joliet -rock user-data meta-data
mv ./seed.iso ../