import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
import IdentityManager from "../abi/IdentityManager.json";
import contractAddress from "../abi/contract-address.json";

const App = () => {
  const [provider, setProvider] = useState(null);
  const [signer, setSigner] = useState(null);
  const [contract, setContract] = useState(null);

  useEffect(() => {
    const init = async () => {
      if (window.ethereum) {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        setProvider(provider);
        const signer = provider.getSigner();
        setSigner(signer);
        const contract = new ethers.Contract(contractAddress.IdentityManager, IdentityManager.abi, signer);
        setContract(contract);
      } else {
        console.error("No Ethereum provider found. Install Metamask.");
      }
    };

    init();
  }, []);

  const addIdentity = async (fingerprint, signature) => {
    try {
      const tx = await contract.addIdentity(fingerprint, signature, true);
      await tx.wait();
      console.log("Identity added:", fingerprint);
    } catch (err) {
      console.error("Error adding identity:", err);
    }
  };

  return (
    <div>
      <h1>Identity Management DApp</h1>
      <button onClick={() => addIdentity("sample_fingerprint", "sample_signature")}>Add Identity</button>
    </div>
  );
};

export default App;
