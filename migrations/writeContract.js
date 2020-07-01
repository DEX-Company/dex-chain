const fs = require('fs')

module.exports = function writeContractArtifact(artifact, network) {

    const artifactData = {
        'name': artifact.contractName,
        'abi': artifact.abi,
        'address': artifact.address,
    }
    const data = JSON.stringify(artifactData);
    fs.writeFileSync(`./artifacts/${artifact.contractName}.${network}.json`, data);
}
