import React, { useState } from "react";
import styled from "styled-components";
import Card from "./card";

export default function CardWrapper(props) {
    nfts = ["test", "test-2", "test-3"]
    return (
        <CardWrap>
            {nfts.map(item => <Card data={item} key={item}/>)}
        </CardWrap>
    );
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