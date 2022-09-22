import React, { useEffect, useState } from "react";
import styled from "styled-components";

export default function Card(props) {
    const [img, setImg] = useState("");
    const data = props.data

    async function resolveImg(ipfsHash) {
        await fetch("https://www.ipfs.io/ipfs" + ipfsHash)
            .then((res) => res.json())
            .then((img) => { setImg(img) })
            .catch((err) => {
                console.log(err.reason)
                console.error(err)
            })
    }

    useEffect(() => resolveImg(data.content_url), [])

    return (
        <CardBox>
            <h5>{data.name}</h5>
            <span>{data.create_date}</span>
            <img src={img} />
            <p>{data.description}</p>
        </CardBox>
    );
}

const CardBox = styled.div`
  width: 250px;
  height: 500px;
  padding: 1em;
  margin: 0.5em;
  border-radius: 15px;
  font-family: sans-serif;
  font-weight: 500;
  font-size: 80%;
  white-space: wrap;
  overflow: hidden;
  text-overflow: ellipsis;
`;