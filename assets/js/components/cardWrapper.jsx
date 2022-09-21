import React, { useState, useEffect } from "react";
import styled from "styled-components";
import Card from "./card";

/* 

  schema "nfts" do
    field :name, :string
    field :description, :string
    field :content_url, :string
    field :type, :string
    field :create_date, :date
    field :graph_id, :string
    field :ipfs, :string

    timestamps()
  end
*/
export default function CardWrapper(props) {
    const [nfts, setNfts] = useState(null);

    async function fetchNfts() {
        await fetch("/api/nfts")
            .then((res) => res.json())
            .then((nfts) => { setNfts(nfts) })
            .catch((err) => {
                console.log(err)
            })
    }

    useEffect(() => {
        fetchNfts();
    })

    let display; 
    
    if (!nfts) {
        display = <p> Please wait... getting nfts</p>
    } else {
        display = <CardWrap> {nfts.map(nft => <Card data={nft} key={nft.ipfs} />)} </CardWrap>

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