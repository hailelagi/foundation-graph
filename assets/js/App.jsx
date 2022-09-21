import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
import { checkConnection } from "./auth";
const { ethereum } = window;

import CardWrapper from "./components/cardWrapper";

export default function App(_params) {
    const [currentAcc, setCurrentAcc] = useState("");
    const [net, setNet] = useState("");
    const [err, setErr] = useState("");

    async function connectWallet() {
        try {
            if (!ethereum) {
                return false;
            } else {
                const accounts = await ethereum.request({ method: "eth_requestAccounts" });
                setCurrentAcc(accounts[0])

                const provider = new ethers.providers.Web3Provider(ethereum);
                const signer = provider.getSigner();
                signer.getAddress()

                console.log(signer._address)

                const network = await provider.getNetwork(ethereum.network);
                setNet(network.name)
                setErr("")

            }
        } catch (err) {
            if (err.code === -32002) {
                setErr("Already processing your request. Check metamask")
            } else {
                setErr(err.message)
            }
            console.log(err)
        };
    };

    useEffect(() => {
        checkConnection();
    })

    let status;
    let displayButton;

    if (currentAcc) {
        status = <h3> you are {currentAcc} on <b>{net}</b></h3>
        displayButton = false;
    } else {
        status = <h3> please sign in with metamask to view nfts! </h3>
        displayButton = true;
    }

    return (
        <>
            <h1> <a href="https://www.foundation.app"> Foundation.app</a> subGraph
                {
                    displayButton && <button className="waveButton" onClick={connectWallet}>
                        connect wallet
                    </button>
                }
            </h1>
            {status}

            {currentAcc && net && <CardWrapper />}
        </>

    )
}

