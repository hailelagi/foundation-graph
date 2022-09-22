import React, { useEffect, useState } from "react";
import styled from "styled-components";

export default function Card(props) {
    const data = props.data
    const ipfsHash = data.content_url

    const ext = ipfsHash.split(".")[1]
    const media = "https://ipfs.io/ipfs" + ipfsHash.split("ipfs:/")[1]

    let displayMedia;
    if (ext == "jpg" | ext == "png" | ext == "gif") {
        displayMedia = <img src={media} />
    } else {
        console.log(media)
        displayMedia = <video width="250px" height="250px" controls><source src={media} type="video/ogg"></source></video>
    }

    return (
        <CardBox>
            <h5>{data.name}</h5>
            <span>{data.create_date}</span>
            {displayMedia}
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