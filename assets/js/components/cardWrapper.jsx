import React, { useState, useEffect } from "react";
import styled from "styled-components";
import Card from "./card";

export default function CardWrapper(props) {
    const [nfts, setNfts] = useState(null);
    const [err, setErr] = useState("");

    async function fetchNfts(userAddress) {
        await fetch("./api/nfts?user=" + userAddress)
            .then((res) => {
                if (res.status == 429) {
                    setErr("Rate Limited.")
                    return

                } else if (res.status == 404) {
                    setErr("Nfts not found")
                    return
                }

                return res.json()
            })
            .then((nfts) => { setNfts(nfts) })
            .catch((err) => {
                console.log(err.reason)
                console.error(err)
            })
    }

    useEffect(() => {
        fetchNfts(props.data);
        const interval = setInterval(() => {
            fetchNfts(props.data)
        }, 10000);

        return () => clearInterval(interval)
    }, [])

    if (nfts) {
        display = <CardWrap> {nfts.map(nft => <Card data={nft} key={nft.graph_id} />)} </CardWrap>
    } else if (err !== "") {
        display = <p id="error">{err}</p>
    } else {
        display = <p> Please wait... getting nfts </p>
    }

    return (<>{display}</>);
}

const CardWrap = styled.div`
  flex: 1 1 auto;
  width: 100%;
  text-align: center;
  padding: 1em;
  display: flex;
  flex-flow: row wrap;
  align-items: center;
  justify-content: center;
`;