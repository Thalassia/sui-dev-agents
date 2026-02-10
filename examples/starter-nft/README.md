# Starter NFT - SUI Move NFT Example

A minimal NFT implementation on SUI with Display standard support.

## What's Included

- **NFT Module**: Basic NFT with metadata (name, description, image URL)
- **Display Integration**: Standard SUI Display for wallet compatibility
- **Mint Function**: Create new NFTs with custom metadata
- **Transfer Function**: Transfer NFTs between addresses
- **Tests**: Example test cases

## Directory Structure

```
starter-nft/
├── Move.toml           # Package configuration
├── sources/
│   └── nft.move       # Main NFT module
└── tests/
    └── nft_tests.move # Test cases (optional)
```

## Quick Start

### Build
```bash
sui move build
```

### Test
```bash
sui move test
```

### Deploy
```bash
sui client publish --gas-budget 100000000
```

## Key Components

### NFT Struct
- `id: UID` - Unique object identifier
- `name: String` - NFT name
- `description: String` - NFT description
- `url: Url` - Image/media URL

### Functions
- `mint(name, description, url)` - Create a new NFT
- `update_description(nft, new_description)` - Update NFT metadata
- `burn(nft)` - Destroy an NFT

## Usage Example

After deployment, mint an NFT:
```bash
sui client call --package <PACKAGE_ID> --module nft --function mint \
  --args "My NFT" "A cool NFT" "https://example.com/image.png" \
  --gas-budget 10000000
```
