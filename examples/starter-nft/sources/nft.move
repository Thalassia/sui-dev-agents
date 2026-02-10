/// A simple NFT module with Display standard support
#[allow(lint(self_transfer))]
module starter_nft::nft {
    use std::string::{String};
    use std::ascii;
    use sui::url::{Self, Url};
    use sui::display;
    use sui::package;

    // ====== Error Codes ======
    #[allow(unused_const)]
    const ENotOwner: u64 = 0;

    // ====== Structs ======

    /// One-time witness for module initialization
    public struct NFT has drop {}

    /// NFT object with metadata
    public struct MyNFT has key, store {
        id: UID,
        name: String,
        description: String,
        url: Url,
    }

    // ====== Module Initializer ======

    fun init(otw: NFT, ctx: &mut TxContext) {
        let keys = vector[
            b"name".to_string(),
            b"description".to_string(),
            b"image_url".to_string(),
        ];

        let values = vector[
            b"{name}".to_string(),
            b"{description}".to_string(),
            b"{url}".to_string(),
        ];

        let publisher = package::claim(otw, ctx);
        let mut display = display::new_with_fields<MyNFT>(
            &publisher, keys, values, ctx
        );
        display::update_version(&mut display);

        transfer::public_transfer(publisher, ctx.sender());
        transfer::public_transfer(display, ctx.sender());
    }

    // ====== Public Functions ======

    /// Mint a new NFT
    public fun mint(
        name: String,
        description: String,
        url: String,
        ctx: &mut TxContext
    ) {
        let nft = MyNFT {
            id: object::new(ctx),
            name,
            description,
            url: url::new_unsafe(ascii::string(*url.as_bytes())),
        };
        transfer::public_transfer(nft, ctx.sender());
    }

    /// Update NFT description (only owner can do this)
    public fun update_description(
        nft: &mut MyNFT,
        new_description: String,
    ) {
        nft.description = new_description;
    }

    /// Burn an NFT
    public fun burn(nft: MyNFT) {
        let MyNFT { id, name: _, description: _, url: _ } = nft;
        object::delete(id);
    }

    // ====== View Functions ======

    public fun name(nft: &MyNFT): String {
        nft.name
    }

    public fun description(nft: &MyNFT): String {
        nft.description
    }

    public fun url(nft: &MyNFT): Url {
        nft.url
    }
}
