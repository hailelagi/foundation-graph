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
                /* const signer = provider.getSigner(); */

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

    return (
        <>
            <h1> it renders</h1>
            <h2>{err}</h2>
            <button className="waveButton" onClick={connectWallet}>
            connect wallet
            </button>

            <h3> you are {currentAcc} </h3>
            <h3> on {net} </h3>

            <CardWrapper />
        </>

    )
}
