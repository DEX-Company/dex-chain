const DatacraftDeployer = require('../src/datacraft-deployer')

const DirectPurchase = artifacts.require("DirectPurchase");
const DatacraftToken = artifacts.require('DatacraftToken')


module.exports = function(deployer, networkName, accounts) {

    const datacraftDeployer = new DatacraftDeployer(deployer)

    deployer.then( async () => {
        await datacraftDeployer.deploy(DirectPurchase, [DatacraftToken.address])
    })

}

