// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

 import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";
    import "@openzeppelin/contracts/utils/Strings.sol";


abstract contract CodingFlare is ERC721Enumerable, Ownable{

    using Strings for uint256;

    string _baseTokenURI;

    uint256 private tokenId;

    uint256 public _price = 0.01 ether;

    address  owner;

    bool _paused;

    error ZEROADDRESS();
    error INSUFFICIENTBALANCE();
    error PAUSED();


   constructor(string memory baseURI) ERC721("CodingFlare", "CFR"){

         owner = msg.sender;

         _baseTokenURI = baseURI;
   }

   event MINTNFT(address indexed to);

     function mint(address _user) external payable {
        require(msg.sender == owner, "Only the minter can mint token");

        if(_paused) {
            revert PAUSED();
        }

        if(_user == address(0)){
            revert ZEROADDRESS();
        }

        if(msg.value < _price){
            revert INSUFFICIENTBALANCE();
        }


        tokenId += 1;

        _safeMint(_user, tokenId);

         string memory url = "https://ipfs.io/ipfs/QmNR3qexwEFdDvrkc1bARsU38diZTuAFSvYgjNMhPXhrsV/";

        emit MINTNFT(msg.sender);

    }

     function _baseURI() internal view virtual override returns (string memory) {
            return _baseTokenURI;
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_tokenId > tokenId,"o");

            string memory baseURI = _baseURI();
            return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }
    function setPaused(bool val) public onlyOwner {
            _paused = val;
    }

        /**
        * @dev withdraw sends all the ether in the contract 
        * to the owner of the contract
         */
     function withdraw() public onlyOwner  {
            address _owner = owner;
            uint256 amount = address(this).balance;
            (bool sent, ) =  _owner.call{value: amount}("");
            require(sent, "Failed to send Ether");
     }

         // Function to receive Ether. msg.data must be empty
    receive() external payable {}

        // Fallback function is called when msg.data is not empty
     fallback() external payable {}

}
