# Art-Marketplace
Creation of ERC-20 token, ERC-721 token, ERC-1155 token and Marketplace

Documentación técnica: Plataforma de Arte Digital Descentralizada
 
Resumen:
Este documento técnico detalla el diseño y la implementación de una plataforma de arte digital descentralizada basada en Ethereum, concretamente en la red de Sepolia, utilizando contratos inteligentes para crear, listar y comerciar tokens ERC-721 y ERC-1155 que representan obras de arte digital. La plataforma también incluye un token ERC-20 personalizado llamado ArtCoin, que se utiliza como moneda para comprar y vender arte en el marketplace.
Introducción
Objetivo 
El objetivo de este documento es presentar una descripción detallada de la plataforma de arte digital descentralizada y sus contratos inteligentes, explicando el caso de uso, los contratos involucrados y las funciones principales de cada contrato.
Descripción general de la plataforma
Contratos involucrados 
La plataforma de arte digital descentralizada se compone de cuatro contratos inteligentes principales:
•	ArtCoin (Token ERC-20)	 
•	DigitalPieces (Token ERC-721) 
•	DigitalCollection (Token ERC-1155) 
•	ArtMarketplace (Marketplace) 
Detalles del contrato
ArtCoin (Token ERC-20) 
El contrato ArtCoin es un token ERC-20 personalizado que se utiliza como moneda en la plataforma para comprar y vender tokens de arte digital. Las funciones principales de este contrato incluyen:
•	Constructor: Crea el token ArtCoin con un suministro inicial.
•	onlyOwner y onlyMinter: Modificadores de acceso que restringen el uso de ciertas funciones a propietarios y creadores de tokens.
•	addMinter y removeMinter: Permiten agregar y eliminar direcciones autorizadas para crear tokens ArtCoin.

DigitalPieces (Token ERC-721) 
El contrato DigitalPieces es un token ERC-721 personalizado que representa piezas únicas de arte digital. Las funciones principales de este contrato incluyen:
•	Constructor: Inicializa el contrato DigitalPieces.
•	awardItem: Crea un nuevo token ERC-721 y lo asigna a una dirección específica.

DigitalCollection (Token ERC-1155) 
El contrato DigitalCollection es un token ERC-1155 personalizado que representa colecciones de arte digital con múltiples copias. Las funciones principales de este contrato incluyen:
•	Constructor: Inicializa el contrato DigitalCollection con una URI base.
•	create: Crea un nuevo token ERC-1155 con una cantidad específica y lo asigna a una dirección específica.
•	setTokenSeller: Establece el vendedor de un token ERC-1155 específico.
•	tokenURI: Obtiene la URI del token para un token ERC-1155 específico.
•	getSeller: Obtiene la dirección del vendedor de un token ERC-1155 específico.

ArtMarketplace (Marketplace)
 El contrato ArtMarketplace es el intermediario en las transacciones de arte digital en la plataforma, facilitando la compra y venta de tokens ERC-721 y ERC-1155. Las funciones principales de este contrato incluyen:
•	Constructor: Inicializa el contrato ArtMarketplace con las direcciones de los contratos de tokens y el porcentaje de comisión.
•	listERC721 y listERC1155: Permiten a un usuario listar un token ERC-721 o ERC-1155 para la venta en el marketplace.
•	buyERC721 y buyERC1155: Permiten a un usuario comprar un token ERC-721 o ERC-1155 listado en el marketplace.
•	getERC721Price y getERC1155Price: Obtienen el precio de un token ERC-721 o ERC-1155 específico listado en el marketplace.
•	isERC721Listed y isERC1155Listed: Verifican si un token ERC-721 o ERC-1155 específico está listado en el marketplace.
•	tokenURI: Obtiene la URI del token para un token ERC-721 específico.
•	setCommissionPercentage: Establece el porcentaje de comisión que el marketplace cobra en las transacciones.
•	withdrawCommission: Permite al propietario del contrato retirar la comisión acumulada en ArtCoin.
•	updateTokenURI: Actualiza la URI del token para un token ERC-721 específico.

Caso de uso
 La plataforma de arte digital descentralizada permite a artistas y coleccionistas crear, comprar y vender arte digital en forma de tokens ERC-721 y ERC-1155. Los usuarios pueden crear y listar tokens de arte en el marketplace, donde otros usuarios pueden comprarlos usando el token ArtCoin. La plataforma cobra una comisión en cada transacción, que se paga en ArtCoin y puede ser retirada por el propietario del contrato.

Conclusión 
Este documento técnico proporciona una descripción detallada de la plataforma de arte digital descentralizada y sus contratos inteligentes. La plataforma permite a artistas y coleccionistas interactuar en un entorno descentralizado y transparente, fomentando la creación y el comercio de arte digital en forma de tokens ERC-721 y ERC-1155. El uso del token ArtCoin como moneda en la plataforma facilita las transacciones y permite a los usuarios beneficiarse de un ecosistema económico cerrado basado en la blockchain de Ethereum.

Enlaces auxiliares a contratos

ArtCoin: https://sepolia.etherscan.io/address/0xd85272fd81d85f2acf9155e486e0a748831ad6ea#code
DigitalPieces: https://sepolia.etherscan.io/address/0x8709ca2e2d53d9a1b2f75e3453479493e7ea8077#code
DigitalCollection: https://sepolia.etherscan.io/address/0x2340066c10db5e228174adf78b4905b6c7fb941f#code
ArtMarketplace: https://sepolia.etherscan.io/address/0x10987aaf9b2414b68b70b6b5b58e13c496472fc7#code



