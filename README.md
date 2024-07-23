# 0g-lab

## Start Akash

```bash
apt update && apt install tmux sudo wget curl -y && tmux
```

## Faucet

```bash
https://faucet.0g.ai/
```

## Explorer

```bash
https://scan-testnet.0g.ai/
```

## Install

```bash
wget -O ogstorage-auto.sh https://raw.githubusercontent.com/annhoami/0g-lab/main/ogstorage-auto.sh && chmod +x ogstorage-auto.sh && ./ogstorage-auto.sh
```

## RPC Endpoint

```bash
https://0g-rpc.dongqn.com
```

## Log

```bash
tail -f ~/0g-storage-node/run/log/zgs.log.$(date +%Y-%m-%d)
```

Success

```bash
2024-06-13T05:53:16.701228Z DEBUG log_entry_sync::sync_manager::log_entry_fetcher: from block number 549992, latest block number 550084, confirmation delay 12
```
